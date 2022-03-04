import 'dart:convert';
import 'dart:io';

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
      Platform.environment['DATABASE_HOST'] ?? '',
      int.tryParse(Platform.environment['DATABASE_PORT'] ?? '0') ?? 0,
      Platform.environment['DATABASE_NAME'] ?? '',
      Platform.environment['DATABASE_USERNAME'] ?? '',
      Platform.environment['DATABASE_PASSWORD'] ?? '',
    );

    final listyStore = DatabaseListyStore(database);

    final thirdy = await listyStore.create('thirdy');

    request.response.statusCode = HttpStatus.ok;
    request.response.write(
      jsonEncode(await thirdy.toMap()),
    );
  }

  @override
  HttpMethod method() => _method;

  @override
  String path() => _path;
}
