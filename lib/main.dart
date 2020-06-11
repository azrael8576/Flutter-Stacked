import 'package:flutter/material.dart';
import 'package:flutterstacked/app/locator.dart';
import 'package:flutterstacked/app/router.gr.dart';
import 'package:flutterstacked/ui/views/login/login_view.dart';
import 'package:stacked_services/stacked_services.dart';

import 'logger.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final log = getLogger('MyApp');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log.i('build');
    return MaterialApp(
//      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: Routes.loginView,
      //Testing only
//      home: LoginView(),
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
