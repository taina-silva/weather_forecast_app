import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/app_module.dart';
import 'package:weather_forecast_app/app/app_widget.dart';
import 'package:weather_forecast_app/app/core/utils/env_vars.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: EnvVars.previewEnabled,
      builder: (_) => ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    ),
  );
}
