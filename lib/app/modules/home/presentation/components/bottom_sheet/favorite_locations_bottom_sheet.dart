import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/favorite_locations_store.dart';

void showFavoriteLocationsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Layout.borderRadiusMedium),
    ),
    builder: (context) => const FavoriteLocations(),
  );
}

class FavoriteLocations extends StatefulWidget {
  const FavoriteLocations({super.key});

  @override
  State<FavoriteLocations> createState() => _FavoriteLocationsState();
}

class _FavoriteLocationsState extends State<FavoriteLocations> {
  final favoriteLocationsStore = Modular.get<FavoriteLocationsStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return favoriteLocationsStore.getFavoriteLocationsState.when(
        initial: () => const SizedBox(),
        loading: () =>
            const SizedBox(height: 160, child: Center(child: CircularProgressIndicator())),
        error: (message) => SizedBox(
          height: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Oops!',
                textType: TextType.large,
                fWeight: FWeight.bold,
                color: AppColors.mainOrange,
              ),
              CustomText(
                text: message,
                textType: TextType.medium,
                fWeight: FWeight.bold,
                color: AppColors.mainBlue,
              ),
            ],
          ),
        ),
        success: () {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: Space.small,
              horizontal: Space.nano,
            ),
            child: ListView.separated(
              itemCount: favoriteLocationsStore.favoriteLocations.length,
              itemBuilder: (context, index) {
                final location = favoriteLocationsStore.favoriteLocations[index];

                return ListTile(
                  title: CustomText(
                    text: location.city,
                    textType: TextType.medium,
                    fWeight: FWeight.bold,
                    color: AppColors.mainBlue,
                  ),
                  subtitle: CustomText(
                    text: location.country,
                    textType: TextType.small,
                    color: AppColors.mainOrange,
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
        },
      );
    });
  }
}
