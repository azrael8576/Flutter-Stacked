import 'package:flutterstacked/app/locator.dart';
import 'package:flutterstacked/app/router.gr.dart';
import 'package:flutterstacked/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DemoViewModel extends BaseViewModel {
  final log = getLogger('DemoViewModel');
  String _title = 'Demo View - Drawer Flip';
  final NavigationService _navigationService = locator<NavigationService>();

  String get title => _title;

  Future navigateToFlightsStepper() async {
    await _navigationService.navigateTo(Routes.flightsStepperView);
  }
}
