import 'package:flutter/material.dart';
import 'package:flutterstacked/ui/views/login/login_view.dart';

import 'logger.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final log = getLogger('MyApp');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log.e('build');
    return MaterialApp(
//      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //Testing only
      home: LoginView(),
    );
  }
}
