// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutterstacked/ui/views/login/login_view.dart';
import 'package:flutterstacked/ui/views/home/home_view.dart';

import '../logger.dart';

abstract class Routes {
  static const loginView = '/';
  static const homeView = '/home-view';
  static const all = {
    loginView,
    homeView,
  };
}

class Router extends RouterBase {
  final log = getLogger('Router');
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    log.i('name: ${settings.name} | arguments: ${settings.arguments}');
    switch (settings.name) {
      case Routes.loginView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginView(),
          settings: settings,
        );
      case Routes.homeView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
