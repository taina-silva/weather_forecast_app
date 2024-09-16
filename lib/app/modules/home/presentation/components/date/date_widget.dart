import 'package:flutter/material.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/daily_weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/core/utils/date_extension.dart';

class DateWidget extends StatelessWidget {
  final DailyWeatherForecastModel item;

  const DateWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: item.date,
          textType: TextType.small,
          fWeight: FWeight.bold,
        ),
        if (DateTime.now().isAtSameDayOfString(item.date))
          const CustomText(
            text: 'Today',
            textType: TextType.small,
            fWeight: FWeight.bold,
            color: AppColors.neutral400,
          ),
      ],
    );
  }
}
