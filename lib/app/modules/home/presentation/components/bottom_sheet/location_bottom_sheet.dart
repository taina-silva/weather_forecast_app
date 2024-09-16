import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/core/components/buttons/custom_button.dart';
import 'package:weather_forecast_app/app/core/routes/animated_route.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/select_city_page.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/select_country_page.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/location_store.dart';

void showLocationBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.mainBlue,
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
    final locationStore = Modular.get<LocationStore>();

    Future<void> navigateToSelectCityPage() async {
      locationStore.getCities(null);

      final result = await Modular.to
          .push(slideRoute((context, animation, secondaryAnimation) => const SelectCityPage()));
      if (result == true) Modular.to.popUntil(ModalRoute.withName(AppRoutes.home));
    }

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
                  text: locationStore.selectedCountry?.name ?? 'Select a country',
                  onTap: () async {
                    final result = await Modular.to.push(slideRoute(
                        (context, animation, secondaryAnimation) => const SelectCountryPage()));
                    if (result == true) await navigateToSelectCityPage();
                  },
                  suffixIcon: Icons.edit_outlined,
                ),
                locationStore.selectedCountry == null
                    ? ButtonType.secondaryOrange
                    : ButtonType.secondaryBlue,
              ),
              const SizedBox(height: Space.small),
              CustomButton(
                ButtonParameters(
                  text: locationStore.selectedCity ?? 'Select a city',
                  onTap: () async => await navigateToSelectCityPage(),
                  suffixIcon: Icons.edit_outlined,
                  isDisabled: locationStore.selectedCountry == null,
                ),
                locationStore.selectedCity == null
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
