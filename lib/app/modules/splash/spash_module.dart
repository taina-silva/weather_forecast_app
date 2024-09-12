import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/app_module.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/pages/splash_page.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/stores/splash_store.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<SplashStore>(SplashStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(AppRoutes.root, child: (context) => const SplashPage());
  }
}
