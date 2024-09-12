import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';
import 'package:weather_forecast_app/app/core/services/logger_service.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/pages/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // Logger
    i.addLazySingleton<LoggerService>((i) => LoggerService());
  }

  @override
  void routes(r) {
    r.child(AppRoutes.root, child: (context) => const SplashPage());
  }
}
