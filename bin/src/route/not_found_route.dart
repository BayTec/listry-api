import 'dart:io';

import '../http_method.dart';
import 'route.dart';

class NotFoundRoute implements Route {
  final String _path;

  NotFoundRoute(this._path);

  @override
  Future<void> handleRequest(HttpRequest request) async {
    request.response.statusCode = HttpStatus.notFound;
    request.response.write('This page does not exist.');
  }

  @override
  HttpMethod method() {
    return HttpMethod.get;
  }

  @override
  String path() {
    return _path;
  }
}
