import 'dart:math';

import 'package:flutter/material.dart';

abstract class Api {
  static const String weatherDailyParams =
      'temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,precipitation_sum,rain_sum,showers_sum,snowfall_sum,precipitation_probability_max,precipitation_probability_min,precipitation_probability_mean,wind_speed_10m_max,et0_fao_evapotranspiration';
}

abstract class Layout {
  static const double borderRadiusNano = 4;
  static const double borderRadiusSmall = 8;
  static const double borderRadiusMedium = 16;
  static const double borderRadiusLarge = 100;

  static const double appBarSize = 88;
  static const double appBarTrailingHeight = 52;
  static const double appBarLeadingAndTrailingWidth = 40;

  static const double bottomNavBarSize = 60;

  static BoxShadow boxShadow(Color color) => BoxShadow(
        color: color.withOpacity(0.5),
        spreadRadius: 0.5,
        blurRadius: 0.5,
        offset: const Offset(0, 0.5),
      );

  static double bottomPadding(BuildContext context) =>
      max(24, MediaQuery.of(context).padding.bottom);
}

abstract class FFamily {
  static const String k2d = 'K2D';
}

abstract class FWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

abstract class Space {
  static const double nano = 8;
  static const double small = 16;
  static const double medium = 24;
  static const double large = 32;
}

abstract class Assets {
  static const String logo = 'assets/logo/logo.png';
  static const String icons = 'assets/icons';
  static const String images = 'assets/images';
  static const String jsons = 'assets/jsons';
}
