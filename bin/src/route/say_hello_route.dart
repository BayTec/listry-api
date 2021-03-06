import 'dart:io';

import '../http_method.dart';
import 'route.dart';

class SayHelloRoute implements Route {
  final Uri _path;
  final HttpMethod _method;

  SayHelloRoute()
      : _path = Uri(pathSegments: ['say-hello']),
        _method = HttpMethod.get;

  @override
  Future<void> handleRequest(HttpRequest request) async {
    request.response.statusCode = HttpStatus.ok;
    request.response.write('Hello there.');
  }

  @override
  HttpMethod method() => _method;

  @override
  Uri path() => _path;
}
