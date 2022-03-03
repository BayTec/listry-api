import 'dart:convert';
import 'dart:io';

import 'package:postgres/postgres.dart';

import '../database/postgres_database.dart';
import '../http_method.dart';
import '../listy_store/database_listy_store.dart';
import 'route.dart';

class TestRoute implements Route {
  final String _path;
  final HttpMethod _method;

  TestRoute()
      : _path = '/test',
        _method = HttpMethod.get;

  @override
  Future<void> handleRequest(HttpRequest request) async {
    final database = PostgresDatabase(
      PostgreSQLConnection(
        'db',
        5432,
        'listry',
        username: 'listry',
        password: 'listry',
      ),
    );

    final listyStore = DatabaseListyStore(database);

    await listyStore.create('firsty');

    request.response.statusCode = HttpStatus.ok;
    request.response.write(
      jsonEncode(
        await database.query('''
          SELECT * FROM listy.listy;
        '''),
      ),
    );
  }

  @override
  HttpMethod method() => _method;

  @override
  String path() => _path;
}
