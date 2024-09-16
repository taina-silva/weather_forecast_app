import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast_app/app/core/errors/failures.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/position/position_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/daily_weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_property_model.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/core/services/network_service/network_service.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/favorite_locations_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/fetch_weather_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/exceptions.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/failures.dart';
import 'package:weather_forecast_app/app/modules/home/infra/repositories/fetch_weather_repository.dart';

import 'fetch_weather_repository_test.mocks.dart';

@GenerateMocks([FetchWeatherDatasource, FavoriteLocationsDatasource, NetworkService, LoggerService])
void main() {
  late FetchWeatherDatasource fetchWeatherDatasource;
  late FavoriteLocationsDatasource favoriteLocationsDatasource;
  late NetworkService networkService;
  late LoggerService loggerService;
  late FetchWeatherRepository repository;

  setUp(() {
    fetchWeatherDatasource = MockFetchWeatherDatasource();
    favoriteLocationsDatasource = MockFavoriteLocationsDatasource();
    networkService = MockNetworkService();
    loggerService = MockLoggerService();
    repository = FetchWeatherRepositoryImpl(
      fetchWeatherDatasource,
      favoriteLocationsDatasource,
      networkService,
      loggerService,
    );
  });

  group('fetchPositionFromLocation', () {
    const location = LocationModel(city: 'city', country: 'country');
    const position = PositionModel(latitude: 0.0, longitude: 0.0);

    test('Should return a PositionModel', () async {
      // arrange
      when(networkService.isConnected).thenReturn(true);
      when(fetchWeatherDatasource.fetchPositionFromLocation(location))
          .thenAnswer((_) async => position);

      // act
      final result = await repository.fetchPositionFromLocation(location);

      // assert
      expect(result, const Right(position));
    });

    test('Should return a NoConnectionFailure when there is no connection', () async {
      // arrange
      when(networkService.isConnected).thenReturn(false);

      // act
      final result = await repository.fetchPositionFromLocation(location);

      // assert
      expect(result, const Left(NoConnectionFailure()));
    });

    test('Should return a FetchPositionFromLocationFailure when an error occurs', () async {
      // arrange
      when(networkService.isConnected).thenReturn(true);
      when(fetchWeatherDatasource.fetchPositionFromLocation(location))
          .thenThrow(const FetchPositionFromLocationException());

      // act
      final result = await repository.fetchPositionFromLocation(location);

      // assert
      expect(result, Left(FetchPositionFromLocationFailure(location)));
    });
  });

  group('fetchWeather', () {
    const location = LocationModel(city: 'city', country: 'country');
    const position = PositionModel(latitude: 0.0, longitude: 0.0);
    const weather = WeatherForecastModel(
      latitude: 0.0,
      longitude: 0.0,
      timezone: 'America/Sao_Paulo',
      timezoneAbbreviation: 'GMT',
      elevation: 0,
      daily: [
        DailyWeatherForecastModel(
          date: '2024-10-10',
          maxTemperature: WeatherPropertyModel(value: '0.0', unit: 'C'),
          minTemperature: WeatherPropertyModel(value: '0.0', unit: 'C'),
          apparentMaxTemperature: WeatherPropertyModel(value: '0.0', unit: 'C'),
          apparentMinTemperature: WeatherPropertyModel(value: '0.0', unit: 'C'),
          precipationSum: WeatherPropertyModel(value: '0.0', unit: 'mm'),
          rainSum: WeatherPropertyModel(value: '0.0', unit: 'mm'),
          showersSum: WeatherPropertyModel(value: '0.0', unit: 'mm'),
          snowfallSum: WeatherPropertyModel(value: '0.0', unit: 'mm'),
          precipitationProbabilityMax: WeatherPropertyModel(value: '0.0', unit: '%'),
          precipitationProbabilityMin: WeatherPropertyModel(value: '0.0', unit: '%'),
          precipitationProbabilityMean: WeatherPropertyModel(value: '0.0', unit: '%'),
          winSpeedMax: WeatherPropertyModel(value: '0.0', unit: 'm/s'),
          evapotranspiration: WeatherPropertyModel(value: '0.0', unit: 'mm'),
        )
      ],
    );

    test('Should return a WeatherForecastModel', () async {
      // arrange
      when(favoriteLocationsDatasource.fetchFavoriteLocationDetailed(location))
          .thenAnswer((_) async => null);
      when(networkService.isConnected).thenReturn(true);
      when(fetchWeatherDatasource.fetchPositionFromLocation(location))
          .thenAnswer((_) async => position);
      when(fetchWeatherDatasource.fetchWeather(position)).thenAnswer((_) async => weather);

      // act
      final result = await repository.fetchWeather(location);

      // assert
      expect(result, const Right(weather));
      verifyNever(favoriteLocationsDatasource.addFavoriteLocationWithWeather(location, weather));
    });

    test('Should return a WeatherForecastModel from favorite location', () async {
      // arrange
      when(favoriteLocationsDatasource.fetchFavoriteLocationDetailed(location))
          .thenAnswer((_) async => weather);
      when(networkService.isConnected).thenReturn(false);

      // act
      final result = await repository.fetchWeather(location);

      // assert
      expect(result, const Right(weather));
      verifyNever(fetchWeatherDatasource.fetchPositionFromLocation(location));
      verifyNever(fetchWeatherDatasource.fetchWeather(position));
      verifyNever(favoriteLocationsDatasource.addFavoriteLocationWithWeather(location, weather));
    });

    test('Should return a NoConnectionFailure when there is no connection', () async {
      // arrange
      when(favoriteLocationsDatasource.fetchFavoriteLocationDetailed(location))
          .thenAnswer((_) async => null);
      when(networkService.isConnected).thenReturn(false);

      // act
      final result = await repository.fetchWeather(location);

      // assert
      expect(result, const Left(NoConnectionFailure()));
      verifyNever(fetchWeatherDatasource.fetchPositionFromLocation(location));
      verifyNever(fetchWeatherDatasource.fetchWeather(position));
      verifyNever(favoriteLocationsDatasource.addFavoriteLocationWithWeather(location, weather));
    });

    test('Should update weather from favorite location', () async {
      // arrange
      const favorite = WeatherForecastModel(
        latitude: 0.0,
        longitude: 0.0,
        timezone: 'America/Sao_Paulo',
        timezoneAbbreviation: 'GMT',
        elevation: 0,
        daily: [
          DailyWeatherForecastModel(
            date: '2021-09-10',
            maxTemperature: WeatherPropertyModel(value: '0.0', unit: 'C'),
            minTemperature: WeatherPropertyModel(value: '0.0', unit: 'C'),
            apparentMaxTemperature: WeatherPropertyModel(value: '0.0', unit: 'C'),
            apparentMinTemperature: WeatherPropertyModel(value: '0.0', unit: 'C'),
            precipationSum: WeatherPropertyModel(value: '0.0', unit: 'mm'),
            rainSum: WeatherPropertyModel(value: '0.0', unit: 'mm'),
            showersSum: WeatherPropertyModel(value: '0.0', unit: 'mm'),
            snowfallSum: WeatherPropertyModel(value: '0.0', unit: 'mm'),
            precipitationProbabilityMax: WeatherPropertyModel(value: '0.0', unit: '%'),
            precipitationProbabilityMin: WeatherPropertyModel(value: '0.0', unit: '%'),
            precipitationProbabilityMean: WeatherPropertyModel(value: '0.0', unit: '%'),
            winSpeedMax: WeatherPropertyModel(value: '0.0', unit: 'm/s'),
            evapotranspiration: WeatherPropertyModel(value: '0.0', unit: 'mm'),
          )
        ],
      );

      when(favoriteLocationsDatasource.fetchFavoriteLocationDetailed(location))
          .thenAnswer((_) async => favorite);
      when(networkService.isConnected).thenReturn(true);
      when(fetchWeatherDatasource.fetchPositionFromLocation(location))
          .thenAnswer((_) async => position);
      when(fetchWeatherDatasource.fetchWeather(position)).thenAnswer((_) async => weather);

      // act
      final result = await repository.fetchWeather(location);

      // assert
      expect(result, const Right(weather));
      verify(favoriteLocationsDatasource.addFavoriteLocationWithWeather(location, weather))
          .called(1);
    });
  });
}
