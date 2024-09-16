import 'package:flutter/material.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';

class CustomScaffold extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Color backgroundColor;
  final Color statusBarColor;

  const CustomScaffold({
    super.key,
    this.appBar = const SizedBox(),
    this.body = const SizedBox(),
    this.floatingActionButton,
    this.backgroundColor = AppColors.background,
    this.statusBarColor = AppColors.background,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            color: statusBarColor,
          ),
          appBar,
          Expanded(child: body),
        ],
      ),
    );
  }
}
