import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast_app/app/core/errors/failures.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/daily_weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_property_model.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/failures.dart';
import 'package:weather_forecast_app/app/modules/home/infra/repositories/fetch_weather_repository.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/weather_states.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/weather_store.dart';

import 'weather_store_test.mocks.dart';

@GenerateMocks([FetchWeatherRepository])
void main() {
  late FetchWeatherRepository repository;
  late WeatherStore store;

  setUp(() {
    repository = MockFetchWeatherRepository();
    store = WeatherStore(repository);
  });

  const location = LocationModel(city: 'city', country: 'country');
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

  provideDummy<Either<Failure, WeatherForecastModel>>(const Right(weather));
  provideDummy<Either<Failure, WeatherForecastModel>>(const Left(NoConnectionFailure()));
  provideDummy<Either<Failure, WeatherForecastModel>>(Left(FetchWeatherFailure()));

  test('Should update state GetWeatherSuccessState', () async {
    // Arrange
    when(repository.fetchWeather(location)).thenAnswer((_) async => const Right(weather));

    final stateChanges = [];
    mobx.reaction(
      (_) => store.state,
      (newState) => stateChanges.add(newState),
    );

    // Act
    await store.fetchWeather(location);

    // Assert
    expect(stateChanges, [
      isA<GetWeatherLoadingState>(),
      isA<GetWeatherErrorState>(),
    ]);
    expect((store.state as GetWeatherSuccessState).weatherForecast, weather);
  });

  test('Should update state GetWeatherNoConnectionState', () async {
    // Arrange
    when(repository.fetchWeather(location))
        .thenAnswer((_) async => const Left(NoConnectionFailure()));

    final stateChanges = [];
    mobx.reaction(
      (_) => store.state,
      (newState) => stateChanges.add(newState),
    );

    // Act
    await store.fetchWeather(location);

    // Assert
    expect(stateChanges, [
      isA<GetWeatherLoadingState>(),
      isA<GetWeatherNoConnectionState>(),
    ]);
  });

  test('Should update state GetWeatherErrorState', () async {
    // Arrange
    when(repository.fetchWeather(location)).thenAnswer((_) async => Left(FetchWeatherFailure()));

    final stateChanges = [];
    mobx.reaction(
      (_) => store.state,
      (newState) => stateChanges.add(newState),
    );

    // Act
    await store.fetchWeather(location);

    // Assert
    expect(stateChanges, [
      isA<GetWeatherLoadingState>(),
      isA<GetWeatherErrorState>(),
    ]);
  });
}
