import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/daily_weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_property_model.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/weather/column_weather_property_widget.dart';

class ThirdCardWeatherForecast extends StatelessWidget {
  final DailyWeatherForecastModel item;

  const ThirdCardWeatherForecast({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Widget precipitationWidget(String label, WeatherPropertyModel property) {
      return Column(
        children: [
          ColumnWeatherPropertyWidget(
            label: Tuple2(label, AppColors.neutral100),
            property: Tuple3(property, AppColors.mainBlue, TextType.medium),
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ],
      );
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.all(Radius.circular(Layout.borderRadiusSmall)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: Space.small,
              right: Space.small,
              top: Space.small,
            ),
            child: Column(
              children: [
                ColumnWeatherPropertyWidget(
                  label: const Tuple2('Precipitation Sum', AppColors.neutral100),
                  property: Tuple3(item.precipationSum, AppColors.mainOrange, TextType.large),
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                const SizedBox(height: Space.normal),
                Wrap(
                  spacing: Space.normal,
                  children: [
                    precipitationWidget('Rain', item.rainSum),
                    precipitationWidget('Showers', item.showersSum),
                    precipitationWidget('Snowfall', item.snowfallSum),
                  ],
                ),
                const Divider(color: AppColors.neutral100, height: 2 * Space.big, thickness: 1),
                const CustomText(
                  text: 'Precipitation Probability',
                  textType: TextType.medium,
                  fWeight: FWeight.bold,
                  color: AppColors.mainOrange,
                ),
                const SizedBox(height: Space.normal),
                Wrap(
                  spacing: Space.normal,
                  children: [
                    precipitationWidget('Max', item.precipitationProbabilityMax),
                    precipitationWidget('Min', item.precipitationProbabilityMin),
                    precipitationWidget('Mean', item.precipitationProbabilityMean),
                  ],
                ),
                const SizedBox(height: Space.normal),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(Layout.borderRadiusSmall),
            child: const Image(image: AssetImage('${Assets.icons}/precipitation.png')),
          ),
        ],
      ),
    );
  }
}
