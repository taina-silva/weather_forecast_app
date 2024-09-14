import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';

abstract class Layout {
  static const double borderRadiusNano = 4;
  static const double borderRadiusSmall = 8;
  static const double borderRadiusMedium = 16;
  static const double borderRadiusBig = 100;

  static const double appBarSize = 72;
  static const double appBarTrailingHeight = 52;
  static const double appBarLeadingAndTrailingWidth = 40;

  static const double bottomNavBarSize = 60;

  static BoxShadow boxShadow = BoxShadow(
    color: AppColors.primaryBlue.withOpacity(0.5),
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
  static const double normal = 24;
  static const double big = 32;
}

abstract class Assets {
  static const String logo = 'assets/logo/logo.png';
  static const String icons = 'assets/icons';
  static const String jsons = 'assets/jsons';
}
