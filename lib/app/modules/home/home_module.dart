import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const HomePage(),
    );
  }
}
