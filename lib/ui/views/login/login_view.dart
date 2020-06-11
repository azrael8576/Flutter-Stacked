import 'package:flutter/material.dart';
import 'package:flutterstacked/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(model.title),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: () => model.navigateToHome()),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
