import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final ButtonParameters params;
  final ButtonType type;

  const CustomButton(this.params, this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !params.isDisabled && !params.isLoading ? params.onTap : null,
      child: Container(
        height: params.height,
        width: params.width,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Layout.borderRadiusSmall),
          color: _backgroundColor,
          border: Border.all(
            width: 1,
            color: _borderColor,
          ),
        ),
        child: params.isLoading ? _buttonLoading : _buttonContent,
      ),
    );
  }

  Widget get _buttonLoading {
    return Center(
      child: SizedBox(
        height: params.height / 2,
        width: params.height / 2,
        child: CircularProgressIndicator(
          color: _contentColor,
          strokeWidth: params.height / 15,
        ),
      ),
    );
  }

  Widget get _buttonContent {
    List<Widget> content = [
      if (params.prefixIcon != null) ...[
        Icon(
          params.prefixIcon,
          size: params.iconsSize,
          color: _contentColor,
        ),
        const SizedBox(width: 8),
      ],
      Center(
        child: CustomText(
          text: params.text,
          textAlign: TextAlign.center,
          textType: params.textType,
          fWeight: FWeight.bold,
          color: _contentColor,
        ),
      ),
      if (params.suffixIcon != null) ...[
        const SizedBox(width: 8),
        Icon(
          params.suffixIcon,
          size: params.iconsSize,
          color: _contentColor,
        ),
      ],
    ];

    return Container(
      margin: EdgeInsets.only(
        left: params.contentAlignment == ButtonContentAlignment.left ? 20 : 0,
        right: params.contentAlignment == ButtonContentAlignment.right ? 20 : 0,
      ),
      child: Row(
        mainAxisAlignment: () {
          switch (params.contentAlignment) {
            case ButtonContentAlignment.left:
              return MainAxisAlignment.start;
            case ButtonContentAlignment.right:
              return MainAxisAlignment.end;
            case ButtonContentAlignment.center:
              return MainAxisAlignment.center;
            default:
              return MainAxisAlignment.center;
          }
        }(),
        children: content,
      ),
    );
  }

  Color get _backgroundColor {
    switch (type) {
      case ButtonType.primaryBlue:
        if (params.isDisabled) return AppColors.neutral200;
        return AppColors.mainBlue;
      case ButtonType.primaryOrange:
        if (params.isDisabled) return AppColors.neutral200;
        return AppColors.mainOrange;
      case ButtonType.primaryYellow:
        if (params.isDisabled) return AppColors.neutral200;
        return AppColors.mainYellow;

      case ButtonType.secondaryBlue || ButtonType.secondaryOrange || ButtonType.secondaryYellow:
        return AppColors.neutral0;
    }
  }

  Color get _borderColor {
    switch (type) {
      case ButtonType.primaryBlue || ButtonType.primaryOrange || ButtonType.primaryYellow:
        return Colors.transparent;
      case ButtonType.secondaryBlue:
        if (params.isDisabled) return AppColors.neutral200;
        return AppColors.mainBlue;
      case ButtonType.secondaryOrange:
        if (params.isDisabled) return AppColors.neutral200;
        return AppColors.mainOrange;
      case ButtonType.secondaryYellow:
        if (params.isDisabled) return AppColors.neutral200;
        return AppColors.mainYellow;
    }
  }

  Color get _contentColor {
    switch (type) {
      case ButtonType.primaryBlue || ButtonType.primaryOrange || ButtonType.primaryYellow:
        if (params.isDisabled) return AppColors.neutral400;
        return AppColors.neutral0;
      case ButtonType.secondaryBlue:
        if (params.isDisabled) return AppColors.neutral200;
        return AppColors.mainBlue;
      case ButtonType.secondaryOrange:
        if (params.isDisabled) return AppColors.neutral200;
        return AppColors.mainOrange;
      case ButtonType.secondaryYellow:
        if (params.isDisabled) return AppColors.neutral200;
        return AppColors.mainYellow;
    }
  }
}

enum ButtonType {
  primaryBlue,
  secondaryBlue,
  primaryOrange,
  secondaryOrange,
  primaryYellow,
  secondaryYellow,
}

enum ButtonContentAlignment {
  left,
  center,
  right,
}

class ButtonParameters extends Equatable {
  final String text;
  final TextType textType;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final int maxLines;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double iconsSize;
  final bool isDisabled;
  final bool isLoading;
  final Color? overrideBackgroundColor;
  final ButtonContentAlignment? contentAlignment;

  const ButtonParameters({
    required this.text,
    this.textType = TextType.nano,
    this.onTap,
    this.width = double.infinity,
    this.height = 52,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.iconsSize = 20,
    this.isLoading = false,
    this.isDisabled = false,
    this.overrideBackgroundColor,
    this.contentAlignment = ButtonContentAlignment.center,
  });

  @override
  List<Object?> get props {
    return [
      text,
      textType,
      isLoading,
      onTap,
      width,
      height,
      maxLines,
      prefixIcon,
      suffixIcon,
      isDisabled,
      iconsSize,
      overrideBackgroundColor,
      contentAlignment,
    ];
  }

  ButtonParameters copyWith({
    String? text,
    TextType? textType,
    bool? isLoading,
    VoidCallback? onTap,
    double? width,
    double? height,
    int? maxLines,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool? isDisabled,
    double? iconsSize,
    bool? displayAsColumn,
    ButtonContentAlignment? contentAlignment,
  }) {
    return ButtonParameters(
      text: text ?? this.text,
      textType: textType ?? this.textType,
      isLoading: isLoading ?? this.isLoading,
      onTap: onTap ?? this.onTap,
      width: width ?? this.width,
      height: height ?? this.height,
      maxLines: maxLines ?? this.maxLines,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      isDisabled: isDisabled ?? this.isDisabled,
      iconsSize: iconsSize ?? this.iconsSize,
      contentAlignment: contentAlignment ?? this.contentAlignment,
    );
  }
}
