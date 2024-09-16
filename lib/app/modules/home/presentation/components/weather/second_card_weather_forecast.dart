import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/daily_weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/weather/column_weather_property_widget.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/weather/row_weather_property_widget.dart';

class SecondCardWeatherForecast extends StatelessWidget {
  final DailyWeatherForecastModel item;

  const SecondCardWeatherForecast({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Space.small),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusSmall)),
        boxShadow: [Layout.boxShadow(AppColors.neutral300)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColumnWeatherPropertyWidget(
                label: const Tuple2('Min: ', AppColors.neutral100),
                property: Tuple3(item.minTemperature, AppColors.mainBlue, TextType.large),
              ),
              const SizedBox(height: Space.small),
              RowWeatherPropertyWidget(
                label: const Tuple2('Max Apparent Temperature: ', AppColors.neutral100),
                property: Tuple3(item.apparentMaxTemperature, AppColors.neutral600, TextType.small),
              ),
              RowWeatherPropertyWidget(
                label: const Tuple2('Mix Apparent Temperature: ', AppColors.neutral100),
                property: Tuple3(item.apparentMinTemperature, AppColors.neutral600, TextType.small),
              ),
              const Divider(color: AppColors.neutral100, height: Space.big, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ColumnWeatherPropertyWidget(
                        label: const Tuple2('Humidity: ', AppColors.neutral100),
                        property:
                            Tuple3(item.evapotranspiration, AppColors.mainOrange, TextType.large),
                      ),
                      const SizedBox(height: Space.small),
                      Image.asset(
                        '${Assets.icons}/evapotranspiration.png',
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ColumnWeatherPropertyWidget(
                        label: const Tuple2('Wind Speed Max: ', AppColors.neutral100),
                        property: Tuple3(item.winSpeedMax, AppColors.mainOrange, TextType.large),
                      ),
                      const SizedBox(height: Space.small),
                      Image.asset(
                        '${Assets.icons}/wind_speed.png',
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
