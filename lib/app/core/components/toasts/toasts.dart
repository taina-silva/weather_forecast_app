import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';

enum ToastType { success, warning, error }

extension _ToastTypeExtension on ToastType {
  Color get color {
    switch (this) {
      case ToastType.success:
        return AppColors.success500;
      case ToastType.warning:
        return AppColors.info300;
      case ToastType.error:
        return AppColors.error500;
    }
  }

  IconData get icon {
    switch (this) {
      case ToastType.success:
        return Icons.check;
      case ToastType.warning:
        return Icons.error_outline_rounded;
      case ToastType.error:
        return Icons.close;
    }
  }
}

void showToast(
  BuildContext context,
  String text,
  ToastType type, {
  Duration fadeDuration = const Duration(milliseconds: 500),
  Duration toastDuration = const Duration(seconds: 3),
}) {
  _showToast(
    context: context,
    text: text,
    type: type,
    fadeDuration: fadeDuration,
    toastDuration: toastDuration,
  );
}

void _showToast({
  required BuildContext context,
  required String text,
  required ToastType type,
  Duration fadeDuration = const Duration(milliseconds: 500),
  Duration toastDuration = const Duration(seconds: 3),
}) {
  final FToast fToast = FToast()..init(context);

  final Widget toast = Container(
    padding: const EdgeInsets.symmetric(
      horizontal: Space.medium,
      vertical: Space.nano,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Layout.borderRadiusNano),
      color: type.color,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(type.icon, color: AppColors.neutral0),
        const SizedBox(width: 12),
        Expanded(
          child: CustomText(
            text: text,
            textType: TextType.small,
            textAlign: TextAlign.center,
            color: AppColors.neutral0,
            fWeight: FWeight.bold,
          ),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    fadeDuration: fadeDuration,
    toastDuration: toastDuration,
  );
}
