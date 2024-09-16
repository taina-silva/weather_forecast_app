import 'package:flutter/material.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';

class TemporaryWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? message;
  final Widget? content;

  const TemporaryWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.message,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    Widget divider =
        const Divider(color: AppColors.mainYellow, height: 2 * Space.large, thickness: 1);

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('${Assets.images}/background.png'),
                fit: BoxFit.cover,
                opacity: 0.85,
              ),
            ),
          ),
        ),
        Align(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Space.medium),
            margin: const EdgeInsets.only(top: 2 * Space.large),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainOrange,
                  ),
                ),
                divider,
                CustomText(
                  text: subtitle,
                  textType: TextType.medium,
                  fWeight: FWeight.bold,
                  textAlign: TextAlign.center,
                  color: AppColors.mainBlue,
                ),
                if (message != null) ...[
                  const SizedBox(height: Space.nano),
                  CustomText(
                    text: message!,
                    textType: TextType.small,
                    textAlign: TextAlign.center,
                    color: AppColors.neutral400,
                  ),
                ],
                if (content != null) ...[
                  const SizedBox(height: Space.medium),
                  content!,
                ],
                divider,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
