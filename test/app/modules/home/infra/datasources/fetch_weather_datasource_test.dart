// import 'fetch_weather_datasource_test.mocks.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/position/position_model.dart';
import 'package:weather_forecast_app/app/core/models/response/rest_client_response.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/core/services/rest_client/rest_client.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/fetch_weather_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/exceptions.dart';

import 'fetch_weather_datasource_test.mocks.dart';

@GenerateMocks([RestClient, LoggerService])
void main() {
  late RestClient client;
  late LoggerService logger;
  late FetchWeatherDatasource datasource;

  setUp(() {
    client = MockRestClient();
    logger = MockLoggerService();
    datasource = FetchWeatherDatasourceImpl(client, logger);
  });

  group('fetchPositionFromLocation', () {
    const location = LocationModel(city: 'city', country: 'country');

    test('Should fetch position from location', () async {
      // arrange
      final data = [
        {'lat': 0.0, 'lon': 0.0}
      ];

      when(client.get(
        'direct',
        baseUrl: anyNamed('baseUrl'),
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async {
        return RestClientResponse(
            data: data, statusCode: 200, statusMessage: 'OK', stackTrace: null);
      });

      // act
      final result = await datasource.fetchPositionFromLocation(location);

      // assert
      expect(result, PositionModel.fromMap(Map<String, dynamic>.from(data[0])));
    });

    test('Should throw FetchPositionFromLocationException when an error occurs', () async {
      // arrange
      when(client.get(
        'direct',
        baseUrl: anyNamed('baseUrl'),
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(Exception());

      // act
      final call = datasource.fetchPositionFromLocation(location);

      // assert
      expect(() => call, throwsA(isA<FetchPositionFromLocationException>()));
    });
  });

  group('fetchWeather', () {
    const position = PositionModel(latitude: 0.0, longitude: 0.0);

    test('Should fetch weather', () async {
      // arrange
      final data = {
        "latitude": 52.52,
        "longitude": 13.419998,
        "generationtime_ms": 0.598907470703125,
        "utc_offset_seconds": 0,
        "timezone": "GMT",
        "timezone_abbreviation": "GMT",
        "elevation": 38.0,
        "daily_units": {
          "time": "iso8601",
          "temperature_2m_max": "°C",
          "temperature_2m_min": "°C",
          "apparent_temperature_max": "°C",
          "apparent_temperature_min": "°C",
          "precipitation_sum": "mm",
          "rain_sum": "mm",
          "showers_sum": "mm",
          "snowfall_sum": "cm",
          "precipitation_probability_max": "%",
          "precipitation_probability_min": "%",
          "precipitation_probability_mean": "%",
          "wind_speed_10m_max": "km/h",
          "et0_fao_evapotranspiration": "mm"
        },
        "daily": {
          "time": [
            "2024-09-16",
            "2024-09-17",
            "2024-09-18",
            "2024-09-19",
            "2024-09-20",
            "2024-09-21",
            "2024-09-22"
          ],
          "temperature_2m_max": [17.9, 24.1, 24.0, 23.2, 22.2, 21.4, 20.9],
          "temperature_2m_min": [12.8, 14.4, 14.0, 14.2, 13.6, 11.2, 12.5],
          "apparent_temperature_max": [17.3, 24.0, 23.3, 21.9, 20.5, 19.2, 20.6],
          "apparent_temperature_min": [10.7, 14.0, 13.9, 13.9, 12.8, 9.6, 11.8],
          "precipitation_sum": [4.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00],
          "rain_sum": [4.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00],
          "showers_sum": [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00],
          "snowfall_sum": [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00],
          "precipitation_probability_max": [90, 0, 0, 3, 3, 0, 0],
          "precipitation_probability_min": [0, 0, 0, 0, 0, 0, 0],
          "precipitation_probability_mean": [23, 0, 0, 1, 0, 0, 0],
          "wind_speed_10m_max": [19.4, 13.5, 13.4, 13.8, 14.1, 13.0, 6.6],
          "et0_fao_evapotranspiration": [0.99, 2.73, 2.93, 2.78, 2.78, 2.68, 1.98]
        }
      };

      when(client.get(
        'forecast',
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async {
        return RestClientResponse(
            data: data, statusCode: 200, statusMessage: 'OK', stackTrace: null);
      });

      // act
      final result = await datasource.fetchWeather(position);

      // assert
      expect(result, WeatherForecastModel.fromRemoteMap(Map<String, dynamic>.from(data)));
    });

    test('Should throw FetchWeatherException when response data is null', () async {
      // arrange
      when(client.get(
        'forecast',
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async {
        return const RestClientResponse(
            data: null, statusCode: 200, statusMessage: 'OK', stackTrace: null);
      });

      // act
      final call = datasource.fetchWeather(position);

      // assert
      expect(() => call, throwsA(isA<FetchWeatherException>()));
    });

    test('Should throw FetchWeatherException when an error occurs', () async {
      // arrange
      when(client.get(
        'forecast',
        queryParameters: anyNamed('queryParameters'),
      )).thenThrow(Exception());

      // act
      final call = datasource.fetchWeather(position);

      // assert
      expect(() => call, throwsA(isA<FetchWeatherException>()));
    });
  });
}
