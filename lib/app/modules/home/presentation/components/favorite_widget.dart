import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/core/components/buttons/custom_button.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/bottom_sheet/favorite_locations_bottom_sheet.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/favorite_locations_store.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/location_store.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/favorite_locations_states.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/weather_states.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/weather_store.dart';

class FavoriteWidget extends StatefulWidget {
  final bool hideSaveAsFavorite;

  const FavoriteWidget({
    super.key,
    this.hideSaveAsFavorite = false,
  });

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  final favoriteStore = Modular.get<FavoriteLocationsStore>();
  final locationStore = Modular.get<LocationStore>();
  final weatherStore = Modular.get<WeatherStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      bool isManipulating =
          favoriteStore.manipulateFavoriteLocationState is ManipulateFavoriteLocationLoadingState;
      LocationModel location = LocationModel(
        city: locationStore.selectedCity ?? '',
        country: locationStore.selectedCountry?.name ?? '',
      );
      bool isFavorite = favoriteStore.isFavorite(location);

      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Space.nano,
          vertical: Space.small,
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: CustomButton(
                ButtonParameters(
                  text: 'Favorite Locations',
                  onTap: () {
                    favoriteStore.getFavoriteLocations();
                    showFavoriteLocationsBottomSheet(context);
                  },
                ),
                ButtonType.secondaryOrange,
              ),
            ),
            if (!widget.hideSaveAsFavorite)
              IconButton(
                onPressed: () {
                  if (isManipulating) return;

                  if (isFavorite) {
                    favoriteStore.removeFavoriteLocation(location);
                    return;
                  }

                  if (weatherStore.state is GetWeatherSuccessState) {
                    favoriteStore.addFavoriteLocation(
                      location,
                      (weatherStore.state as GetWeatherSuccessState).weatherForecast,
                    );
                  }
                },
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border_outlined),
                iconSize: 40,
                color: isManipulating ? AppColors.neutral100 : AppColors.mainBlue,
              ),
          ],
        ),
      );
    });
  }
}
