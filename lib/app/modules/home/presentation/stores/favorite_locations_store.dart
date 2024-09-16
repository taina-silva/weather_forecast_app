import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/modules/home/infra/repositories/favorite_locations_repository.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/favorite_locations_states.dart';

part 'favorite_locations_store.g.dart';

class FavoriteLocationsStore = FavoriteLocationsStoreBase with _$FavoriteLocationsStore;

abstract class FavoriteLocationsStoreBase with Store {
  final FavoriteLocationsRepository _repository;

  FavoriteLocationsStoreBase(this._repository) {
    getFavoriteLocations();
  }

  @observable
  GetFavoriteLocationsState getFavoriteLocationsState = GetFavoriteLocationsInitialState();

  @observable
  ManipulateFavoriteLocationState manipulateFavoriteLocationState =
      ManipulateFavoriteLocationInitialState();

  @observable
  ObservableList<LocationModel> favoriteLocations = ObservableList<LocationModel>();

  bool isFavorite(LocationModel location) => favoriteLocations.contains(location);

  @action
  Future<void> getFavoriteLocations() async {
    getFavoriteLocationsState = GetFavoriteLocationsLoadingState();

    final result = await _repository.fetchFavoritesLocations();

    result.fold(
      (l) => getFavoriteLocationsState = GetFavoriteLocationsErrorState(l.message),
      (r) {
        favoriteLocations = r.asObservable();
        getFavoriteLocationsState = GetFavoriteLocationsSuccessState();
      },
    );
  }

  @action
  Future<void> addFavoriteLocation(LocationModel location, WeatherForecastModel weather) async {
    manipulateFavoriteLocationState = ManipulateFavoriteLocationLoadingState();

    final result = await _repository.addFavoriteLocationWithWeather(location, weather);

    result.fold(
      (l) => manipulateFavoriteLocationState = ManipulateFavoriteLocationErrorState(l.message),
      (r) {
        favoriteLocations.add(location);
        manipulateFavoriteLocationState =
            ManipulateFavoriteLocationSuccessState('Location added to favorites');
      },
    );
  }

  @action
  Future<void> removeFavoriteLocation(LocationModel location) async {
    manipulateFavoriteLocationState = ManipulateFavoriteLocationLoadingState();

    final result = await _repository.removeFavoriteLocation(location);

    result.fold(
      (l) => manipulateFavoriteLocationState = ManipulateFavoriteLocationErrorState(l.message),
      (r) {
        favoriteLocations.remove(location);
        manipulateFavoriteLocationState =
            ManipulateFavoriteLocationSuccessState('Location removed from favorites');
      },
    );
  }
}
