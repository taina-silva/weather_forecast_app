import 'package:fpdart/fpdart.dart';
import 'package:weather_forecast_app/app/core/errors/failures.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/core/services/network_service/network_service.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/favorite_locations_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/fetch_weather_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/exceptions.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/failures.dart';

abstract class FetchWeatherRepository {
  Future<Either<Failure, WeatherForecastModel>> fetchWeather(LocationModel location);
}

class FetchWeatherRepositoryImpl implements FetchWeatherRepository {
  final FetchWeatherDatasource _fetchWeatherDatasource;
  final FavoriteLocationsDatasource _favoriteLocationsDatasource;
  final NetworkService _networkService;
  final LoggerService _loggerService;

  FetchWeatherRepositoryImpl(
    this._fetchWeatherDatasource,
    this._favoriteLocationsDatasource,
    this._networkService,
    this._loggerService,
  );

  @override
  Future<Either<Failure, WeatherForecastModel>> fetchWeather(LocationModel location) async {
    try {
      final favorite = await _favoriteLocationsDatasource.fetchFavoriteLocationDetailed(location);

      if (!_networkService.isConnected) {
        if (favorite == null) return const Left(NoConnectionFailure());
        return Right(favorite);
      }

      final position = await _fetchWeatherDatasource.fetchPositionFromLocation(location);
      final weather = await _fetchWeatherDatasource.fetchWeather(position);

      if (favorite != null) {
        if (favorite.daily.first.date != weather.daily.first.date) {
          try {
            await _favoriteLocationsDatasource.addFavoriteLocationWithWeather(location, weather);
          } catch (_) {
            _loggerService.error(
                'Error adding favorite location (${location.city} - ${location.country}) with weather.');
          }
        }
      }

      return Right(weather);
    } on FetchPositionFromLocationException catch (_) {
      return Left(FetchPositionFromLocationFailure(location));
    } on FetchWeatherException catch (_) {
      return Left(FetchWeatherFailure());
    } on FetchFavoriteLocationDetailedException catch (_) {
      return Left(FetchFavoriteLocationDetailedFailure());
    }
  }
}
