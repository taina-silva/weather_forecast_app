import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_forecast_app/app/core/components/app_bar/custom_app_bar.dart';
import 'package:weather_forecast_app/app/core/components/scaffold/custom_scaffold.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/theme/status_bar_theme.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/date/date_widget.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/favorite/favorite_widget.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/location/location_bottom_sheet.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/weather/first_card_weather_forecast.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/weather/second_card_weather_forecast.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/weather/third_card_weather_forecast.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/location_store.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/weather_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final locationStore = Modular.get<LocationStore>();
  final weatherStore = Modular.get<WeatherStore>();

  int index = 0;

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();
    changeStatusBarTheme(StatusBarTheme.light, AppColors.mainBlue);

    reactions = [
      reaction(
        (_) => locationStore.selectedCity,
        (city) {
          if (city != null) weatherStore.fetchWeather(city);
        },
      ),
    ];
  }

  Widget arrowWidget(bool show, IconData icon, void Function() onTap) {
    return IconButton(
      onPressed: show ? () => setState(() => onTap()) : null,
      icon: Icon(icon),
      iconSize: 40,
      color: show ? AppColors.mainBlue : AppColors.neutral0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: Observer(builder: (context) {
        return CustomAppBar(
          title: Left(
            Tuple2(
              locationStore.selectedCity == null && locationStore.selectedCountry == null
                  ? 'Select a location'
                  : '${locationStore.selectedCity ?? '_'}, ${locationStore.selectedCountry?.name ?? '_'}',
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
      body: Observer(
        builder: (context) {
          return Container(
            margin: const EdgeInsets.only(top: Space.normal),
            child: weatherStore.state.when(
              initial: () => const SizedBox(),
              loading: () => const Center(child: CircularProgressIndicator()),
              noConnection: () => const Center(child: Text('No connection')),
              error: (message) => Center(
                child: CustomText(
                  text: message,
                  textType: TextType.medium,
                ),
              ),
              success: (result) {
                final item = result.daily[index];
                final hasPrevious = index > 0;
                final hasNext = index < result.daily.length - 1;

                return Column(
                  children: [
                    const FavoriteWidget(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          left: Space.normal,
                          right: Space.normal,
                          top: Space.normal,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(Layout.borderRadiusMedium),
                            topRight: Radius.circular(Layout.borderRadiusMedium),
                          ),
                          boxShadow: [Layout.boxShadow(AppColors.lightBlue)],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                arrowWidget(
                                    hasPrevious, Icons.navigate_before_rounded, () => index -= 1),
                                DateWidget(item: item),
                                arrowWidget(hasNext, Icons.navigate_next_rounded, () => index += 1),
                              ],
                            ),
                            Expanded(
                              child: CustomScrollView(
                                slivers: [
                                  SliverList(
                                    delegate: SliverChildListDelegate(
                                      [
                                        const SizedBox(height: Space.normal),
                                        FirstCardWeatherForecast(item: item),
                                        const SizedBox(height: Space.normal),
                                        SecondCardWeatherForecast(item: item),
                                        const SizedBox(height: Space.normal),
                                        ThirdCardWeatherForecast(item: item),
                                        const SizedBox(height: Space.normal),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
