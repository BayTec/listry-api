import 'dart:io';

import '../http_method.dart';
import '../route/not_found_route.dart';
import '../route/route.dart';
import 'router.dart';

class ApiRouter implements Router {
  final List<Route> _routes;

  ApiRouter(this._routes);

  @override
  Future<void> route(HttpRequest request) async {
    final route = routes().firstWhere(
      (element) =>
          element.path() == request.uri.path &&
          element.method() == methodFromString(request.method),
      orElse: () => NotFoundRoute(request.uri.path),
    );

    await route.handleRequest(request);
  }

  @override
  List<Route> routes() {
    return _routes;
  }
}
