import 'dart:io';

import 'src/router/api_router.dart';
import 'src/router/router.dart';
import 'src/routes.dart';

final Router router = ApiRouter(routes);

void main(List<String> arguments) async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4040);
  await for (final request in server) {
    await router.route(request);
    await request.response.close();
  }
}
