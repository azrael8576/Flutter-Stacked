import 'package:flutterstacked/logger.dart';
import 'package:stacked/stacked.dart';

class DemoViewModel extends BaseViewModel {
  final log = getLogger('DemoViewModel');
  String _title = 'Demo View - Drawer Flip';

  String get title => _title;
}
