import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/core/components/buttons/custom_button.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/favorite_locations_store.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/favorite_locations_states.dart';

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
  final store = Modular.get<FavoriteLocationsStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      bool isManipulating =
          store.manipulateFavoriteLocationState is ManipulateFavoriteLocationLoadingState;

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
                  onTap: () => store.getFavoriteLocations(),
                ),
                ButtonType.secondaryOrange,
              ),
            ),
            if (!widget.hideSaveAsFavorite)
              IconButton(
                onPressed: isManipulating ? null : () {},
                icon: const Icon(Icons.favorite_border_outlined),
                iconSize: 40,
                splashRadius: 0.01,
                color: isManipulating ? AppColors.neutral100 : AppColors.mainBlue,
              ),
          ],
        ),
      );
    });
  }
}
