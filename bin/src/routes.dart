import 'route/listy/get_listies_route.dart';
import 'route/listy/get_listy_route.dart';
import 'route/route.dart';
import 'route/say_hello_route.dart';
import 'route/test_route.dart';

final List<Route> routes = [
  SayHelloRoute(),
  TestRoute(),
  GetListiesRoute(),
  GetListyRoute(),
];
