import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    Modular.to.addListener(navigationListener);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> dispose() async {
    Modular.to.removeListener(navigationListener);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void navigationListener() {
    Modular.get<LoggerService>().log('[NAV]: ${Modular.to.path}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp.router(
        title: 'Weather Forecast App',
        debugShowCheckedModeBanner: false,
        scrollBehavior: const CustomScrollBehavior(),
        theme: ThemeData(
          useMaterial3: false,
          fontFamily: FFamily.k2d,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        builder: DevicePreview.appBuilder,
        routerConfig: Modular.routerConfig,
      ),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
