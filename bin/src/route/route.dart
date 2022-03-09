import 'dart:io';

import '../http_method.dart';

abstract class Route {
  Uri path();
  HttpMethod method();
  Future<void> handleRequest(HttpRequest request);
}
