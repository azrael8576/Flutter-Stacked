import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterstacked/ui/shared/app_colors.dart';
import 'package:flutterstacked/ui/shared/ui_helpers.dart';
import 'package:flutterstacked/ui/views/login/login_viewmodel.dart';
import 'package:flutterstacked/ui/widgets/button_widget.dart';
import 'package:flutterstacked/ui/widgets/textfield_widget.dart';
import 'package:flutterstacked/ui/widgets/wave_widget.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.nonReactive(
      builder: (context, model, child) {
        model.updateScreenSize(MediaQuery.of(context).size);
        model.isKeyboardOpen(MediaQuery.of(context).viewInsets.bottom > 0);
        return Scaffold(
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Stack(
              children: <Widget>[
                _LoginTitleContainer(),
                _LoginTitleText(),
                _LoginTitleAnimatedPositioned(),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _AccountTextField(),
                      UIHelper.verticalSpaceSmall,
                      _PasswordTextField(),
                      UIHelper.verticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          UIHelper.standardText(text: 'Forgot password?'),
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,
                      _LoginButton(),
                      UIHelper.verticalSpaceSmall,
                      _SignUpButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

class _LoginTitleContainer extends ViewModelWidget<LoginViewModel> {
  const _LoginTitleContainer([Key key]) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return Container(
      height: viewModel.screenSize.height - 200,
      color: AppColors.mediumBlue,
    );
  }
}

class _LoginTitleText extends ViewModelWidget<LoginViewModel> {
  _LoginTitleText([Key key]) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            viewModel.title,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginTitleAnimatedPositioned extends ViewModelWidget<LoginViewModel> {
  const _LoginTitleAnimatedPositioned([Key key])
      : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeOutQuad,
      top: viewModel.keyboardOpen ? -viewModel.screenSize.height / 3.7 : 0.0,
      child: WaveWidget(
        size: viewModel.screenSize,
        yOffset: viewModel.screenSize.height / 3.0,
        color: AppColors.white,
      ),
    );
  }
}

class _AccountTextField extends ViewModelWidget<LoginViewModel> {
  const _AccountTextField([Key key]) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return TextFieldWidget(
      hintText: 'Email',
      obscureText: false,
      prefixIconData: Icons.mail_outline,
      suffixIconData: viewModel.isValid ? Icons.check : null,
      onChange: (value) {
        viewModel.isValidEmail(value);
//                          tokenBloc.userId = value;
      },
    );
  }
}

class _PasswordTextField extends ViewModelWidget<LoginViewModel> {
  const _PasswordTextField([Key key]) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return TextFieldWidget(
      hintText: 'Password',
      onTap: () => viewModel.isVisible = !viewModel.isVisible,
      obscureText: viewModel.isVisible,
      prefixIconData: Icons.lock_outline,
      suffixIconData:
          viewModel.isVisible ? Icons.visibility : Icons.visibility_off,
      onChange: (value) {
//        tokenBloc.password = value;
      },
    );
  }
}

class _LoginButton extends ViewModelWidget<LoginViewModel> {
  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return ButtonWidget(
      title: 'Login',
      onTap: () async {
//        var loginStatus = await AppModule.to.bloc<TokenBloc>().login();
//        if (loginStatus == true) {
          viewModel.navigateToHome();
//        }
      },
      hasBorder: false,
    );
  }
}


class _SignUpButton extends ViewModelWidget<LoginViewModel> {
  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return ButtonWidget(
      title: 'SignUp',
      onTap: () async {

      },
      hasBorder: true,
    );
  }
}