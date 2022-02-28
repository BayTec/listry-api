import 'dart:io';

import '../http_method.dart';

abstract class Route {
  String path();
  HttpMethod method();
  Future<void> handleRequest(HttpRequest request);
}
