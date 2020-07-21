import 'package:flutterstacked/app/locator.dart';
import 'package:flutterstacked/app/router.gr.dart';
import 'package:flutterstacked/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DraggableScrollableSheetViewModel extends BaseViewModel {
  final log = getLogger('DraggableScrollableSheetViewModel');
  String _title = 'Draggable Scrollable Sheet View';
  final NavigationService _navigationService = locator<NavigationService>();

  String get title => _title;

  Future navigateToDemo() async {
//    await _navigationService.navigateTo(Routes.demoView);
  }
}
