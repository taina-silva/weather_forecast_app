import 'package:flutter/material.dart';
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
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
