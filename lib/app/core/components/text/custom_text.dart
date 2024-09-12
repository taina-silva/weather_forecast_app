import 'package:flutter/material.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';

enum TextType { nano, small, medium, large }

class CustomText extends StatelessWidget {
  final String text;
  final TextType textType;
  final FontWeight fWeight;
  final Color color;
  final int? maxLines;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final TextDecoration textDecoration;
  final FontStyle? fontStyle;

  const CustomText({
    super.key,
    required this.text,
    required this.textType,
    this.fWeight = FWeight.regular,
    this.color = AppColors.neutral900,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.textOverflow = TextOverflow.visible,
    this.textDecoration = TextDecoration.none,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    double getTextScaleFactor() {
      switch (textType) {
        case TextType.nano:
          return 1;
        case TextType.small:
          return 1.2;
        case TextType.medium:
          return 1.5;
        case TextType.large:
          return 2;
      }
    }

    int getMaxLines() {
      switch (textType) {
        case TextType.nano:
          return 1;
        case TextType.small:
          return 2;
        case TextType.medium:
          return 3;
        case TextType.large:
          return 4;
      }
    }

    return Text(
      text,
      textScaler: TextScaler.linear(getTextScaleFactor()),
      maxLines: maxLines ?? getMaxLines(),
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fWeight,
        color: color,
        fontStyle: fontStyle,
        decoration: textDecoration,
      ),
      softWrap: true,
      overflow: textOverflow,
    );
  }
}
