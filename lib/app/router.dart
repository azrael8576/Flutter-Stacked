import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutterstacked/ui/views/home/home_view.dart';
import 'package:flutterstacked/ui/views/login/login_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  LoginView loginView;
  HomeView homeView;
}