import 'package:fpdart/fpdart.dart';
import 'package:weather_forecast_app/app/core/errors/failures.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/position/position_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/services/network_service/network_service.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/fetch_weather_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/exceptions.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/failures.dart';

abstract class FetchWeatherRepository {
  Future<Either<Failure, PositionModel>> fetchPositionFromLocation(LocationModel location);
  Future<Either<Failure, WeatherForecastModel>> fetchWeather(LocationModel location);
}

class FetchWeatherRepositoryImpl implements FetchWeatherRepository {
  final FetchWeatherDatasource _datasource;
  final NetworkService _networkService;

  FetchWeatherRepositoryImpl(this._datasource, this._networkService);

  @override
  Future<Either<Failure, PositionModel>> fetchPositionFromLocation(LocationModel location) async {
    try {
      if (!_networkService.isConnected) {
        return const Left(NoConnectionFailure());
      }

      final position = await _datasource.fetchPositionFromLocation(location);
      return Right(position);
    } on FetchPositionFromLocationException catch (_) {
      return Left(FetchPositionFromLocationFailure(location));
    }
  }

  @override
  Future<Either<Failure, WeatherForecastModel>> fetchWeather(LocationModel location) async {
    try {
      if (!_networkService.isConnected) {
        return const Left(NoConnectionFailure());
      }

      final position = await _datasource.fetchPositionFromLocation(location);
      final result = await _datasource.fetchWeather(position);

      return Right(result);
    } on FetchPositionFromLocationException catch (_) {
      return Left(FetchPositionFromLocationFailure(location));
    } on FetchWeatherException catch (_) {
      return Left(FetchWeatherFailure());
    }
  }
}
