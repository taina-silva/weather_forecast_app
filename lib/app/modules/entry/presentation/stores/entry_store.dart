import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';

part 'entry_store.g.dart';

class EntryStore = EntryStoreBase with _$EntryStore;

abstract class EntryStoreBase with Store {
  @readonly
  int _currentPage = 0;

  @action
  Future<void> changePage(int index) async {
    _currentPage = index;

    if (index == 0) {
      Modular.to.navigate(AppRoutes.entryHome);
    } else if (index == 1) {
      Modular.to.navigate(AppRoutes.entryFavorites);
    }
  }
}
