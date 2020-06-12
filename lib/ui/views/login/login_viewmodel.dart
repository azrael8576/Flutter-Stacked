import 'dart:ui';

import 'package:flutterstacked/app/locator.dart';
import 'package:flutterstacked/app/router.gr.dart';
import 'package:flutterstacked/logger.dart';
import 'package:flutterstacked/ui/shared/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final log = getLogger('LoginViewModel');
  final NavigationService _navigationService = locator<NavigationService>();
  String _title = 'Login';
  Size _screenSize;
  bool _keyboardOpen;
  bool _isValid = false;
  bool _isVisible = true;


  String get title => _title;
  Size get screenSize => (_screenSize != null) ? _screenSize : null;
  bool get keyboardOpen => (_keyboardOpen != null) ? _keyboardOpen : null;
  bool get isValid => _isValid;
  bool get isVisible => _isVisible;

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
  Future navigateToHome() async {
    await _navigationService.navigateTo(Routes.homeView);
  }
}