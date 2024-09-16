import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/app_module.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/fetch_weather_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/repositories/fetch_weather_repository.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/home_page.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/location_store.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/weather_store.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    // Location
    i.addLazySingleton<LocationStore>(LocationStore.new);

    // Weather
    i.add<FetchWeatherDatasource>(FetchWeatherDatasourceImpl.new);
    i.add<FetchWeatherRepository>(FetchWeatherRepositoryImpl.new);
    i.addLazySingleton<WeatherStore>(WeatherStore.new);
  }

  @override
  void routes(r) {
    r.child(
      AppRoutes.root,
      child: (context) => const HomePage(),
    );
  }
}
