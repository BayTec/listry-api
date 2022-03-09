import 'dart:io';

import '../http_method.dart';
import 'route.dart';

class NotFoundRoute implements Route {
  final Uri _path;

  NotFoundRoute(this._path);

  @override
  Future<void> handleRequest(HttpRequest request) async {
    request.response.statusCode = HttpStatus.notFound;
    request.response.write('This page does not exist.');
  }

  @override
  HttpMethod method() => HttpMethod.get;

  @override
  Uri path() => _path;
}
