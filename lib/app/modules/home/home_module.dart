import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/app_module.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/home_page.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/select_city_page.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/select_country_page.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/home_store.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<HomeStore>(HomeStore.new);
  }

  @override
  void routes(r) {
    r.child(
      AppRoutes.root,
      child: (context) => const HomePage(),
    );
    r.child(
      '/select-country',
      child: (context) => const SelectCountryPage(),
    );
    r.child(
      '/select-city',
      child: (context) => const SelectCityPage(),
    );
  }
}
