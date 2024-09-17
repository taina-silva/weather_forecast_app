import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:weather_forecast_app/app/core/components/buttons/custom_button.dart';
import 'package:weather_forecast_app/app/core/components/structure/custom_app_bar.dart';
import 'package:weather_forecast_app/app/core/components/structure/custom_scaffold.dart';
import 'package:weather_forecast_app/app/core/components/structure/temporary_widget.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/text_field/location_text_field.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/location_store.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/location_states.dart';

class SelectCityPage extends StatefulWidget {
  const SelectCityPage({super.key});

  @override
  State<SelectCityPage> createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  final locationStore = Modular.get<LocationStore>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: Observer(builder: (context) {
        return CustomAppBar(
          title: Right(
            LocationTextField<String>(
              selectedLocation: locationStore.selectedCity,
              onClear: () => locationStore.setSelectedCity(null),
              getLocations: locationStore.fetchCities,
              locationAsStr: (city) => city,
              labelText: 'City',
              disabled: locationStore.getCitiesState is GetCitiesNoConnectionState,
            ),
          ),
        );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.medium),
        child: CustomButton(
          ButtonParameters(
            text: 'Go back',
            onTap: () => Modular.to.pop(),
          ),
          ButtonType.secondaryOrange,
        ),
      ),
      body: Observer(
        builder: (context) {
          return locationStore.getCitiesState.when(
            initial: () => const SizedBox(),
            loading: () =>
                const Center(child: CircularProgressIndicator(color: AppColors.mainBlue)),
            error: (message) => TemporaryWidget(
              title: 'Oops!',
              subtitle: message,
            ),
            noConnection: () => const TemporaryWidget(
              title: 'No connection!',
              subtitle: 'Please check your internet connection.',
            ),
            successWithData: (cities) {
              if (cities.isEmpty) {
                return const TemporaryWidget(
                  title: 'No cities found!',
                  subtitle: 'Please try another search.',
                );
              }

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: Space.nano),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(top: Space.nano),
                        itemCount: cities.length,
                        itemBuilder: (context, index) {
                          final city = cities[index];

                          return ListTile(
                            title: CustomText(
                              text: city,
                              textType: TextType.small,
                            ),
                            onTap: () {
                              locationStore.setSelectedCity(city);
                              Modular.to.pop(true);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    ),
                    const SizedBox(height: 2.5 * Space.large),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
