import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutterstacked/ui/views/demo/demo_view.dart';
import 'package:flutterstacked/ui/views/flights_stepper/flights_stepper_view.dart';
import 'package:flutterstacked/ui/views/home/home_view.dart';
import 'package:flutterstacked/ui/views/login/login_view.dart';

@MaterialAutoRouter()
class $Router {
  //TODO: Add log TAG to router.gr.dart.Router().
  //TODO: final log = getLogger('Router');
  //TODO: Add log to router.gr.dart.onGenerateRoute().
  //TODO: log.i('name: ${settings.name} | arguments: ${settings.arguments}');
  @initial
  LoginView loginView;
  HomeView homeView;
  DemoView demoView;
  FlightsStepperView flightsStepperView;
}