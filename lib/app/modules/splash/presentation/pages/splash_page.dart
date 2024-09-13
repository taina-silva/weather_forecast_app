import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/components/scaffold/custom_scaffold.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/stores/splash_store.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/stores/states/splash_states.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final store = Modular.get<SplashStore>();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();
    store.manageSplash();

    reactions = [
      reaction((_) => store.state, (SplashState state) async {
        if (state is ToEntryState) Modular.to.navigate(AppRoutes.entryHome);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.logo,
              height: MediaQuery.of(context).size.width * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
          ],
        ),
      ),
    );
  }
}
