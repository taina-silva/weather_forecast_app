import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:weather_forecast_app/app/core/components/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/modules/entry/presentation/stores/entry_store.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  EntryPageState createState() => EntryPageState();
}

class EntryPageState extends State<EntryPage> {
  final store = Modular.get<EntryStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: const RouterOutlet(),
      bottomNavigationBar: Observer(
        builder: (_) {
          return BottomNavBar(
            currentIndex: store.currentPage,
            onTap: store.changePage,
          );
        },
      ),
    );
  }
}
