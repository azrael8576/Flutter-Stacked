import 'package:flutterstacked/logger.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger('HomeViewModel');
  String _title = 'Home View';
  String get title => _title;
}