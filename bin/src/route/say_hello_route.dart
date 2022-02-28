import 'dart:io';

import '../http_method.dart';
import 'route.dart';

class SayHelloRoute implements Route {
  final String _path;
  final HttpMethod _method;

  SayHelloRoute()
      : _path = '/say-hello',
        _method = HttpMethod.get;

  @override
  Future<void> handleRequest(HttpRequest request) async {
    request.response.statusCode = HttpStatus.ok;
    request.response.write('Hello there.');
  }

  @override
  HttpMethod method() => _method;

  @override
  String path() => _path;
}
