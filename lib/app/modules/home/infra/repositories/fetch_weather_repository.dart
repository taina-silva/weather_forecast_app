import 'package:fpdart/fpdart.dart';
import 'package:weather_forecast_app/app/core/errors/failures.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/models/position/position_model.dart';
import 'package:weather_forecast_app/app/core/services/network_service/network_service.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/fetch_weather_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/exceptions.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/failures.dart';

abstract class FetchWeatherRepository {
  Future<Either<Failure, PositionModel>> fetchPositionFromCity(String city);
  Future<Either<Failure, WeatherForecastModel>> fetchWeather(String city);
}

class FetchWeatherRepositoryImpl implements FetchWeatherRepository {
  final FetchWeatherDatasource _datasource;
  final NetworkService _networkService;

  FetchWeatherRepositoryImpl(this._datasource, this._networkService);

  @override
  Future<Either<Failure, PositionModel>> fetchPositionFromCity(String city) async {
    try {
      if (!_networkService.isConnected) {
        return const Left(NoConnectionFailure());
      }

      final position = await _datasource.fetchPositionFromCity(city);
      return Right(position);
    } on FetchPositionFromCityException catch (_) {
      return Left(FetchPositionFromCityFailure(city));
    }
  }

  @override
  Future<Either<Failure, WeatherForecastModel>> fetchWeather(String city) async {
    try {
      if (!_networkService.isConnected) {
        return const Left(NoConnectionFailure());
      }

      final position = await _datasource.fetchPositionFromCity(city);
      final result = await _datasource.fetchWeather(position);

      return Right(result);
    } on FetchPositionFromCityException catch (_) {
      return Left(FetchPositionFromCityFailure(city));
    } on FetchWeatherException catch (_) {
      return Left(FetchWeatherFailure());
    }
  }
}
