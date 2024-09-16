import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_property_model.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';

class RowWeatherPropertyWidget extends StatelessWidget {
  final Tuple2<String, Color> label;
  final Tuple3<WeatherPropertyModel, Color, TextType> property;
  final CrossAxisAlignment crossAxisAlignment;

  const RowWeatherPropertyWidget({
    super.key,
    required this.label,
    required this.property,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        CustomText(
          text: label.item1,
          textType: TextType.small,
          color: label.item2,
        ),
        CustomText(
          text: '${property.item1.value}${property.item1.unit}',
          textType: property.item3,
          fWeight: FWeight.bold,
          color: property.item2,
        ),
      ],
    );
  }
}
