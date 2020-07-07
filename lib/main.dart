import 'package:flutter/material.dart';
import 'package:flutterstacked/app/locator.dart';
import 'package:flutterstacked/app/router.gr.dart';
import 'package:flutterstacked/app_config.dart';
import 'package:flutterstacked/services/token_api.dart';
import 'package:flutterstacked/ui/views/login/login_view.dart';
import 'package:stacked_services/stacked_services.dart';

import 'logger.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final log = getLogger('MyApp');
  final TokenApi _tokenApi = locator<TokenApi>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String serverPath = AppConfig.DEBUG ? AppConfig.SINYI_DEVELOPMENT_SERVER : AppConfig.SINYI_PRODUCTION_SERVER;
    log.d("serverPath", serverPath);
    final String apiUrl = serverPath + AppConfig.API_URI_SIFFIX;
    final String apiTokenUrl = serverPath + AppConfig.API_TOKEN_URI_SIFFIX;
    _tokenApi.init(AppConfig.DEBUG, apiTokenUrl, 10000, AppConfig.APP_NAME);
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
