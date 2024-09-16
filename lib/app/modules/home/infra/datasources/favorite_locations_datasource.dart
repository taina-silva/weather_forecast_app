import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/services/local_storage/local_storage.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/exceptions.dart';

abstract class FavoriteLocationsDatasource {
  Future<List<LocationModel>> fetchFavoritesLocations();
  Future<WeatherForecastModel> fetchFavoriteLocationDetailed(LocationModel location);
  Future<void> addFavoriteLocationWithWeather(LocationModel location, WeatherForecastModel weather);
  Future<void> removeFavoriteLocation(LocationModel location);
}

class FavoriteLocationsDatasourceImpl implements FavoriteLocationsDatasource {
  final LocalStorage _localStorage;
  final LoggerService _loggerService;

  FavoriteLocationsDatasourceImpl(this._localStorage, this._loggerService);

  @override
  Future<List<LocationModel>> fetchFavoritesLocations() async {
    try {
      final result = await _localStorage.read<Map<String, dynamic>>('favorite-locations');

      if (result == null) return [];

      final locations = <LocationModel>[];

      for (final value in result['locations'] as List<String>) {
        final city = value.split('/').first;
        final country = value.split('/').last;

        locations.add(LocationModel(city: city, country: country));
      }

      return locations;
    } catch (error, stackTrace) {
      _loggerService.error(error, stackTrace: stackTrace);
      throw FetchFavoriteLocationsException(message: error.toString());
    }
  }

  @override
  Future<WeatherForecastModel> fetchFavoriteLocationDetailed(LocationModel location) async {
    try {
      final result =
          await _localStorage.read<Map<String, dynamic>>('${location.city}-${location.country}');
      if (result == null) throw const FetchFavoriteLocationDetailedException();

      return WeatherForecastModel.fromLocalMap(result);
    } catch (error, stackTrace) {
      _loggerService.error(error, stackTrace: stackTrace);
      throw FetchFavoriteLocationDetailedException(message: error.toString());
    }
  }

  @override
  Future<void> addFavoriteLocationWithWeather(
      LocationModel location, WeatherForecastModel weather) async {
    try {
      final locations = await fetchFavoritesLocations();

      if (!locations.contains(location)) {
        await _localStorage.write('favorite-locations',
            {'locations': locations.map((e) => '${e.city}/${e.country}').toList()});
      }

      await _localStorage.write('${location.city}-${location.country}', weather.toMap());
    } catch (error, stackTrace) {
      _loggerService.error(error, stackTrace: stackTrace);
      throw AddFavoriteLocationException(message: error.toString());
    }
  }

  @override
  Future<void> removeFavoriteLocation(LocationModel location) async {
    try {
      final locations = await fetchFavoritesLocations();

      locations.remove(location);

      await _localStorage.write('favorite-locations',
          {'locations': locations.map((e) => '${e.city}/${e.country}').toList()});

      await _localStorage.delete('${location.city}-${location.country}');
    } catch (error, stackTrace) {
      _loggerService.error(error, stackTrace: stackTrace);
      throw RemoveFavoriteLocationException(message: error.toString());
    }
  }
}
