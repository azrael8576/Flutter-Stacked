import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterstacked/app/locator.dart';
import 'package:flutterstacked/app/router.gr.dart';
import 'package:flutterstacked/datamodels/token_model.dart';
import 'package:flutterstacked/logger.dart';
import 'package:flutterstacked/services/token_api.dart';
import 'package:flutterstacked/ui/shared/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final log = getLogger('LoginViewModel');
  final NavigationService _navigationService = locator<NavigationService>();
  final TokenApi _tokenApi = locator<TokenApi>();
  String _title = 'Login';
  String _account;
  String _password;
  Size _screenSize;
  bool _keyboardOpen;
  bool _isValid = false;
  bool _isVisible = true;
  TokenModel _tokenModel;

  String get title => _title;

  String get account => _account;

  String get password => _password;

  Size get screenSize => (_screenSize != null) ? _screenSize : null;

  bool get keyboardOpen => (_keyboardOpen != null) ? _keyboardOpen : null;

  bool get isValid => _isValid;

  bool get isVisible => _isVisible;

  TokenModel get tokenModel => _tokenModel;

  void isValidEmail(String input) {
    if (input == AppColors.validEmail.first) {
      _isValid = true;
    } else {
      _isValid = false;
    }
    notifyListeners();
  }

  void updateScreenSize(Size size) => _screenSize = size;

  void isKeyboardOpen(bool bool) {
    _keyboardOpen = bool;
    notifyListeners();
  }

  set isVisible(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  @protected
  set account(String value) {
    _account = value;
  }

  @protected
  set password(String value) {
    _password = value;
  }

  Future<bool> loginAction() async {
    var loginStatus = await _tokenApi.GetAuthToken(
        '417437',
        'SummerCozyRock70',
        '81374642-3004-41cf-a3ea-5c4cb6111d3c',
        '9999',
        '1.0.37.393.9999',
        'TA2',
        'samsung SM-N9208',
        '');
    _tokenModel = TokenModel.fromJson(loginStatus);
    if (_tokenModel.status == '1') {
      await navigateToHome();
      return true;
    } else {
      return false;
    }
  }

  Future navigateToHome() async {
    await _navigationService.navigateTo(Routes.homeView);
  }
}
