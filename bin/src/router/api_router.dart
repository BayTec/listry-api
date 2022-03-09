import 'dart:io';

import '../route/not_found_route.dart';
import '../route/route.dart';
import 'router.dart';

class ApiRouter implements Router {
  final List<Route> _routes;

  ApiRouter(this._routes);

  @override
  Future<void> route(HttpRequest request) async {
    final requestPath = request.uri.pathSegments;
    var routes = this.routes().where(
        (element) => element.path().pathSegments.length == requestPath.length);

    for (int i = 0; i < requestPath.length; i++) {
      var iRoutes = routes
          .where((element) => element.path().pathSegments[i] == requestPath[i]);

      if (iRoutes.isEmpty) {
        iRoutes =
            routes.where((element) => element.path().pathSegments[i] == '{*}');
      }

      if (iRoutes.isEmpty) {
        break;
      }

      routes = iRoutes;
    }

    if (routes.isNotEmpty) {
      await routes.first.handleRequest(request);
      return;
    }

    await NotFoundRoute(request.uri).handleRequest(request);
  }

  @override
  List<Route> routes() => _routes;
}
