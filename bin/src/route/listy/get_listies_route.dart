import 'dart:convert';
import 'dart:io';

import '../../database.dart';
import '../../http_method.dart';
import '../../listy_store/database_listy_store.dart';
import '../route.dart';

class GetListiesRoute implements Route {
  final Uri _path;
  final HttpMethod _method;

  GetListiesRoute()
      : _path = Uri(pathSegments: ['listy']),
        _method = HttpMethod.get;

  @override
  Future<void> handleRequest(HttpRequest request) async {
    final database = getDatabase();
    final listyStore = DatabaseListyStore(database);

    final listies = await listyStore.all();

    final List<Map<String, dynamic>> mappedListies = [];

    for (final listy in listies) {
      mappedListies.add(await listy.toMap());
    }

    request.response.statusCode = HttpStatus.ok;
    request.response.write(jsonEncode(mappedListies));
  }

  @override
  HttpMethod method() => _method;

  @override
  Uri path() => _path;
}
