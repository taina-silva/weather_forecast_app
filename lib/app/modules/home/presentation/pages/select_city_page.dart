import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:weather_forecast_app/app/core/components/app_bar/custom_app_bar.dart';
import 'package:weather_forecast_app/app/core/components/buttons/custom_button.dart';
import 'package:weather_forecast_app/app/core/components/scaffold/custom_scaffold.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/location_text_field.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/home_store.dart';

class SelectCityPage extends StatefulWidget {
  const SelectCityPage({super.key});

  @override
  State<SelectCityPage> createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  final homeStore = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: Observer(builder: (context) {
        return CustomAppBar(
          title: Right(
            LocationTextField<String>(
              selectedLocation: homeStore.selectedCity,
              onClear: () => {homeStore.setSelectedCity(null)},
              getLocations: homeStore.getCities,
              locationAsStr: (city) => city,
              labelText: 'City',
            ),
          ),
        );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.normal),
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
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    vertical: Space.normal,
                    horizontal: Space.small,
                  ),
                  itemCount: homeStore.cities.length,
                  itemBuilder: (context, index) {
                    final city = homeStore.cities[index];

                    return GestureDetector(
                      onTap: () {
                        homeStore.setSelectedCity(city);
                        Modular.to.pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(Space.nano),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          border: const Border(
                            bottom: BorderSide(
                              color: AppColors.neutral200,
                              width: 1,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(Layout.borderRadiusSmall),
                          boxShadow: [Layout.boxShadow],
                        ),
                        child: CustomText(
                          text: city,
                          textType: TextType.small,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: Space.nano),
                ),
              ),
              const SizedBox(height: 2.5 * Space.big),
            ],
          );
        },
      ),
    );
  }
}
