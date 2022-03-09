import 'dart:convert';
import 'dart:io';

import '../database.dart';
import '../http_method.dart';
import '../listy_store/database_listy_store.dart';
import 'route.dart';

class TestRoute implements Route {
  final Uri _path;
  final HttpMethod _method;

  TestRoute()
      : _path = Uri(pathSegments: ['test']),
        _method = HttpMethod.get;

  @override
  Future<void> handleRequest(HttpRequest request) async {
    final database = getDatabase();

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
  Uri path() => _path;
}
