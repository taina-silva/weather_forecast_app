import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/pages/splash_page.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/stores/splash_store.dart';

class SplashModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<SplashStore>((i) => SplashStore());
  }

  @override
  void routes(r) {
    r.child(AppRoutes.root, child: (context) => const SplashPage());
  }
}
