import 'package:fpdart/fpdart.dart';
import 'package:weather_forecast_app/app/core/errors/failures.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/favorite_locations_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/exceptions.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/failures.dart';

abstract class FavoriteLocationsRepository {
  Future<Either<Failure, List<LocationModel>>> fetchFavoritesLocations();
  Future<Either<Failure, WeatherForecastModel>> fetchFavoriteLocationDetailed(
      LocationModel location);
  Future<Either<Failure, Unit>> addFavoriteLocationWithWeather(
      LocationModel location, WeatherForecastModel weather);
  Future<Either<Failure, Unit>> removeFavoriteLocation(LocationModel location);
}

class FavoriteLocationsRepositoryImpl implements FavoriteLocationsRepository {
  final FavoriteLocationsDatasource _datasource;

  FavoriteLocationsRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<LocationModel>>> fetchFavoritesLocations() async {
    try {
      final result = await _datasource.fetchFavoritesLocations();

      if (result.isEmpty) {
        return left(const FetchFavoriteLocationsFailure('Empty list of favorite locations'));
      }

      return right(result);
    } on Failure catch (error) {
      return left(error);
    }
  }

  @override
  Future<Either<Failure, WeatherForecastModel>> fetchFavoriteLocationDetailed(
      LocationModel location) async {
    try {
      final result = await _datasource.fetchFavoriteLocationDetailed(location);

      return right(result);
    } on FetchFavoriteLocationDetailedException catch (_) {
      return left(FetchFavoriteLocationDetailedFailure(location: location));
    }
  }

  @override
  Future<Either<Failure, Unit>> addFavoriteLocationWithWeather(
      LocationModel location, WeatherForecastModel weather) async {
    try {
      await _datasource.addFavoriteLocationWithWeather(location, weather);

      return right(unit);
    } on AddFavoriteLocationException catch (_) {
      return left(AddFavoriteLocationFailure(location: location));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFavoriteLocation(LocationModel location) async {
    try {
      await _datasource.removeFavoriteLocation(location);

      return right(unit);
    } on RemoveFavoriteLocationException catch (_) {
      return left(RemoveFavoriteLocationFailure(location: location));
    }
  }
}
