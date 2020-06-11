import 'package:flutterstacked/app/locator.dart';
import 'package:flutterstacked/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  String _title = 'Login View';
  String get title => _title;

  Future navigateToHome() async{
    await _navigationService.navigateTo(Routes.homeView);
  }
}