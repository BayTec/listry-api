import 'dart:io';

import '../route/route.dart';

abstract class Router {
  List<Route> routes();
  Future<void> route(HttpRequest request);
}
