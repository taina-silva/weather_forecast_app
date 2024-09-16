import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/countries_service.dart';
import 'package:weather_forecast_app/app/core/services/local_storage/local_storage.dart';
import 'package:weather_forecast_app/app/core/services/location_service/location_service.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/core/services/network_service/network_service.dart';
import 'package:weather_forecast_app/app/core/services/rest_client/rest_client.dart';
import 'package:weather_forecast_app/app/modules/home/home_module.dart';
import 'package:weather_forecast_app/app/modules/splash/spash_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(i) {
    // Logger
    i.addLazySingleton<LoggerService>(LoggerServiceImpl.new);

    // RestClient
    i.addLazySingleton<RestClient>(RestClientImpl.new);

    // Network
    i.add<Connectivity>(Connectivity.new);
    i.addSingleton<NetworkService>(NetworkServiceImpl.new);

    // Countries
    i.addLazySingleton<CountriesService>(CountriesServiceImpl.new);

    // Location
    i.addSingleton<LocationService>(LocationServiceImpl.new);

    // Local Storage
    i.add<FlutterSecureStorage>(FlutterSecureStorage.new);
    i.addLazySingleton<LocalStorage>(LocalStorageImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.module(AppRoutes.root, module: SplashModule());
    r.module(AppRoutes.home, module: HomeModule());
  }
}
