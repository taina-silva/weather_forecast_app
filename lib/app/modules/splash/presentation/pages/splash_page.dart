import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/components/scaffold/custom_scaffold.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/theme/status_bar_theme.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/stores/splash_store.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/stores/states/splash_states.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final store = Modular.get<SplashStore>();

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    changeStatusBarTheme(StatusBarTheme.light, AppColors.background);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _controller.forward();

    store.manageSplash();

    reactions = [
      reaction((_) => store.state, (SplashState state) async {
        if (state is ToEntryState) Modular.to.navigate(AppRoutes.home);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  Assets.logo,
                  height: MediaQuery.of(context).size.width * 0.8,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
