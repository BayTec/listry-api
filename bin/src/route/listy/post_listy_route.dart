import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../database.dart';
import '../../http_method.dart';
import '../../listy_store/database_listy_store.dart';
import '../route.dart';

class PostListyRoute implements Route {
  final Uri _path;
  final HttpMethod _method;

  PostListyRoute()
      : _path = Uri(pathSegments: ['listy']),
        _method = HttpMethod.post;

  @override
  Future<void> handleRequest(HttpRequest request) async {
    final jsonString = await utf8.decodeStream(request);

    try {
      final obj = json.decode(jsonString);

      final database = getDatabase();
      final store = DatabaseListyStore(database);

      final listy = await store.create(obj['name']);

      request.response.statusCode = HttpStatus.created;
      request.response.write(listy.id());
    } catch (ex) {
      request.response.statusCode = HttpStatus.badRequest;
      request.response.write(ex.toString());
    }
  }

  @override
  HttpMethod method() => _method;

  @override
  Uri path() => _path;
}
