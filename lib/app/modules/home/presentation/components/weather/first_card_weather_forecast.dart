import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/enums/weather_condition.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/daily_weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/weather/column_weather_property_widget.dart';

class FirstCardWeatherForecast extends StatelessWidget {
  final DailyWeatherForecastModel item;

  const FirstCardWeatherForecast({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Space.nano),
      decoration: BoxDecoration(
        color: AppColors.mainBlue,
        border: Border.all(color: AppColors.mainBlue),
        borderRadius: const BorderRadius.all(Radius.circular(Layout.borderRadiusSmall)),
        boxShadow: [Layout.boxShadow(AppColors.mainBlue)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                determineWeatherCondition(item).iconPath,
                width: 100,
                height: 100,
              ),
              Column(
                children: [
                  CustomText(
                    text: determineWeatherCondition(item).name,
                    textType: TextType.large,
                    fWeight: FWeight.bold,
                    color: AppColors.mainOrange,
                  ),
                  const SizedBox(height: Space.nano),
                  ColumnWeatherPropertyWidget(
                    label: const Tuple2('Max', AppColors.neutral0),
                    property: Tuple3(item.maxTemperature, AppColors.neutral0, TextType.large),
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
