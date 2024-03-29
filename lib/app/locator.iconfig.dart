// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutterstacked/services/api.dart';
import 'package:flutterstacked/services/third_party_service_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutterstacked/services/token_api.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServiceModule = _$ThirdPartyServiceModule();
  g.registerLazySingleton<Api>(() => Api());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServiceModule.dialogService);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServiceModule.navigationService);
  g.registerLazySingleton<TokenApi>(() => TokenApi());
}

class _$ThirdPartyServiceModule extends ThirdPartyServiceModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
