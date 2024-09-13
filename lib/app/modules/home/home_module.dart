import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/app_module.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/home_page.dart';
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
      '/',
      child: (context) => const HomePage(),
    );
  }
}
