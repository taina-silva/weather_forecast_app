import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:tuple/tuple.dart';
import 'package:weather_forecast_app/app/core/components/app_bar/custom_app_bar.dart';
import 'package:weather_forecast_app/app/core/components/scaffold/custom_scaffold.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/theme/status_bar_theme.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/location_bottom_sheet.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeStore = Modular.get<HomeStore>();

  @override
  void initState() {
    super.initState();
    changeStatusBarTheme(StatusBarTheme.light, AppColors.primaryBlue);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: Observer(builder: (context) {
        return CustomAppBar(
          title: Left(
            Tuple2(
              homeStore.selectedCity == null && homeStore.selectedCountry == null
                  ? 'Select a location'
                  : '${homeStore.selectedCity ?? '_'}, ${homeStore.selectedCountry?.name ?? '_'}',
              () => showLocationBottomSheet(context),
            ),
          ),
          trailing: [
            IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                color: AppColors.neutral0,
              ),
              onPressed: () => showLocationBottomSheet(context),
            ),
          ],
        );
      }),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
