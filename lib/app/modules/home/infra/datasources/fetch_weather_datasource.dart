import 'package:flutter/foundation.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/models/position/position_model.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/core/services/rest_client/rest_client.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/core/utils/env_vars.dart';
import 'package:weather_forecast_app/app/core/utils/parser_compute.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/exceptions.dart';

abstract class FetchWeatherDatasource {
  Future<PositionModel> fetchPositionFromCity(String city);
  Future<WeatherForecastModel> fetchWeather(PositionModel position);
}

class FetchWeatherDatasourceImpl implements FetchWeatherDatasource {
  final RestClient _client;
  final LoggerService _logger;

  FetchWeatherDatasourceImpl(this._client, this._logger);

  @override
  Future<PositionModel> fetchPositionFromCity(String city) async {
    try {
      final response = await _client.get(
        'direct',
        baseUrl: EnvVars.geoApiUrl,
        queryParameters: {
          'q': city,
          'appid': EnvVars.apiKey,
        },
      );

      return PositionModel.fromMap(response.data[0]);
    } catch (error, stackTrace) {
      _logger.error(error, stackTrace: stackTrace);
      throw FetchPositionFromCityException(message: 'Error fetching position for $city');
    }
  }

  @override
  Future<WeatherForecastModel> fetchWeather(PositionModel position) async {
    try {
      final response = await _client.get(
        'forecast',
        queryParameters: {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'daily': Api.weatherDailyParams,
        },
      );

      if (response.data == null) throw Exception();

      final weather = await compute<ComputeParams<WeatherForecastModel>, WeatherForecastModel>(
        parseItemsInBackground,
        ComputeParams<WeatherForecastModel>(
            response.data, (map) => WeatherForecastModel.fromMap(map)),
      );

      return weather;
    } catch (error, stackTrace) {
      _logger.error(error, stackTrace: stackTrace);
      throw FetchWeatherException(
          message:
              'Error fetching weather for position - lat:${position.latitude}, long:${position.longitude}');
    }
  }
}
