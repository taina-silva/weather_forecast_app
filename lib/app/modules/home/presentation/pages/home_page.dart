import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:mobx/mobx.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_forecast_app/app/core/components/app_bar/custom_app_bar.dart';
import 'package:weather_forecast_app/app/core/components/structure/custom_scaffold.dart';
import 'package:weather_forecast_app/app/core/components/structure/temporary_widget.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/components/toasts/toasts.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/theme/status_bar_theme.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/bottom_sheet/location_bottom_sheet.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/cards/first_card_weather_forecast.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/cards/second_card_weather_forecast.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/cards/third_card_weather_forecast.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/date_widget.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/favorite_widget.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/favorite_locations_store.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/location_store.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/favorite_locations_states.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/weather_states.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/weather_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final locationStore = Modular.get<LocationStore>();
  final weatherStore = Modular.get<WeatherStore>();
  final favoriteLocationsStore = Modular.get<FavoriteLocationsStore>();

  int index = 0;
  late PageController _pageController;

  List<ReactionDisposer> reactions = [];

  @override
  void initState() {
    super.initState();

    changeStatusBarTheme(StatusBarTheme.light, AppColors.mainBlue);

    _pageController = PageController(initialPage: index);

    reactions = [
      reaction((_) => locationStore.selectedCity, (city) {
        if (city == null) {
          weatherStore.state = GetWeatherInitialState();
        } else {
          if (locationStore.selectedCountry != null) {
            weatherStore.fetchWeather(
                LocationModel(city: city, country: locationStore.selectedCountry!.name));
          }
        }
      }),
      reaction((_) => favoriteLocationsStore.manipulateFavoriteLocationState, (state) {
        if (state is ManipulateFavoriteLocationSuccessState) {
          showToast(context, state.message, ToastType.success);
        } else if (state is ManipulateFavoriteLocationErrorState) {
          showToast(context, state.message, ToastType.error);
        }
      })
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget arrowWidget(bool show, IconData icon, void Function() onTap) {
    return IconButton(
      onPressed: !show
          ? null
          : () {
              setState(() {
                onTap();
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOutBack,
                );
              });
            },
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
            child: weatherStore.state.when(
              initial: () => const TemporaryWidget(
                title: 'Welcome!',
                subtitle: 'Select a location to see the weather forecast.',
                message:
                    'Choose from favorites or search for a new location on the top of this screen.',
                content: FavoriteWidget(hideSaveAsFavorite: true),
              ),
              loading: () => const TemporaryWidget(
                title: 'Loading...',
                subtitle: 'Please wait a moment.',
                content: CircularProgressIndicator(color: AppColors.mainBlue),
              ),
              noConnection: () => const TemporaryWidget(
                title: 'No connection!',
                subtitle: 'Please check your internet connection.',
                content: FavoriteWidget(hideSaveAsFavorite: true),
              ),
              error: (message) => Center(
                child: CustomText(
                  text: message,
                  textType: TextType.medium,
                ),
              ),
              successWithData: (result) {
                final item = result.daily[index];
                final hasPrevious = index > 0;
                final hasNext = index < result.daily.length - 1;

                return Column(
                  children: [
                    const FavoriteWidget(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
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
                            const SizedBox(height: Space.small),
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
                              child: PageView.builder(
                                controller: _pageController,
                                onPageChanged: (i) => setState(() => index = i),
                                itemCount: result.daily.length,
                                itemBuilder: (context, i) {
                                  final item = result.daily[i];
                                  return CustomScrollView(
                                    slivers: [
                                      SliverList(
                                        delegate: SliverChildListDelegate(
                                          [
                                            const SizedBox(height: Space.medium),
                                            FirstCardWeatherForecast(item: item),
                                            const SizedBox(height: Space.medium),
                                            SecondCardWeatherForecast(item: item),
                                            const SizedBox(height: Space.medium),
                                            ThirdCardWeatherForecast(item: item),
                                            const SizedBox(height: Space.medium),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
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
