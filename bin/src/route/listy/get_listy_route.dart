import 'dart:convert';
import 'dart:io';

import '../../database.dart';
import '../../http_method.dart';
import '../../listy_store/database_listy_store.dart';
import '../route.dart';

class GetListyRoute implements Route {
  final Uri _path;
  final HttpMethod _method;

  GetListyRoute()
      : _path = Uri(pathSegments: ['listy', '{*}']),
        _method = HttpMethod.get;

  @override
  Future<void> handleRequest(HttpRequest request) async {
    final id = int.tryParse(request.uri.pathSegments.last) ?? -1;

    final database = getDatabase();
    final listyStore = DatabaseListyStore(database);

    final listy = await listyStore.find(id);

    if (listy != null) {
      request.response.statusCode = HttpStatus.ok;
      request.response.write(jsonEncode(await listy.toMap()));
    } else {
      request.response.statusCode = HttpStatus.badRequest;
      request.response.write('The listy with the id: $id was not found.');
    }
  }

  @override
  HttpMethod method() => _method;

  @override
  Uri path() => _path;
}
