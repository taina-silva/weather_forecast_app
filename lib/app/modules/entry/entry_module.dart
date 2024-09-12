import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';
import 'package:weather_forecast_app/app/modules/entry/presentation/pages/entry_page.dart';
import 'package:weather_forecast_app/app/modules/entry/presentation/stores/entry_store.dart';
import 'package:weather_forecast_app/app/modules/home/home_module.dart';
import 'package:weather_forecast_app/app/modules/splash/spash_module.dart';

class EntryModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<EntryStore>((i) => EntryStore());
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const EntryPage(),
      children: [
        ParallelRoute(name: AppRoutes.home, module: HomeModule()),
        ParallelRoute(name: AppRoutes.favorites, module: SplashModule()),
      ],
    );
  }
}
