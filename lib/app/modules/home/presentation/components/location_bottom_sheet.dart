import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/core/components/buttons/custom_button.dart';
import 'package:weather_forecast_app/app/core/routes/animated_route.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/select_city_page.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/select_country_page.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/home_store.dart';

void showLocationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.primaryBlue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Layout.borderRadiusMedium),
    ),
    builder: (_) => const LocationBottomSheet(),
  );
}

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final homeStore = Modular.get<HomeStore>();

    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Container(
          padding: MediaQuery.of(context).viewInsets,
          margin: const EdgeInsets.symmetric(
            horizontal: Space.small,
            vertical: Space.small,
          ),
          child: Column(
            children: [
              CustomButton(
                ButtonParameters(
                  text: homeStore.selectedCountry?.name ?? 'Select a country',
                  onTap: () async {
                    final result = await Modular.to.push(slideRoute(
                        (context, animation, secondaryAnimation) => const SelectCountryPage()));

                    if (result == true) {
                      Modular.to.push(slideRoute(
                          (context, animation, secondaryAnimation) => const SelectCityPage()));
                    }
                  },
                  suffixIcon: Icons.edit_outlined,
                ),
                homeStore.selectedCountry == null
                    ? ButtonType.secondaryOrange
                    : ButtonType.secondaryBlue,
              ),
              const SizedBox(height: Space.small),
              CustomButton(
                ButtonParameters(
                  text: homeStore.selectedCity ?? 'Select a city',
                  onTap: () => Modular.to.push(slideRoute(
                      (context, animation, secondaryAnimation) => const SelectCityPage())),
                  suffixIcon: Icons.edit_outlined,
                ),
                homeStore.selectedCity == null
                    ? ButtonType.secondaryOrange
                    : ButtonType.secondaryBlue,
              ),
            ],
          ),
        ),
      );
    });
  }
}
