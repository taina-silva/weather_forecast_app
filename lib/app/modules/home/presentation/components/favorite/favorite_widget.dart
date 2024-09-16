import 'package:flutter/material.dart';
import 'package:weather_forecast_app/app/core/components/buttons/custom_button.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: Space.nano,
        right: Space.nano,
        bottom: Space.normal,
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: CustomButton(
              ButtonParameters(
                text: 'Favorite Locations',
                onTap: () {},
              ),
              ButtonType.secondaryOrange,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_outlined),
            iconSize: 40,
            splashRadius: 0.01,
            color: AppColors.mainBlue,
          ),
        ],
      ),
    );
  }
}
