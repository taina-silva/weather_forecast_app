import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:weather_forecast_app/app/core/components/app_bar/custom_app_bar.dart';
import 'package:weather_forecast_app/app/core/components/scaffold/custom_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      appBar: CustomAppBar(
        title: Left('Home Page'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
