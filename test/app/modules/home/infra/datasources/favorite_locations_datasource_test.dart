import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/services/local_storage/local_storage.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/favorite_locations_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/exceptions.dart';

import 'favorite_locations_datasource_test.mocks.dart';

@GenerateMocks([LocalStorage, LoggerService])
void main() {
  late LocalStorage localStorage;
  late LoggerService loggerService;
  late FavoriteLocationsDatasource datasource;

  setUp(() {
    localStorage = MockLocalStorage();
    loggerService = MockLoggerService();
    datasource = FavoriteLocationsDatasourceImpl(localStorage, loggerService);
  });

  group('fetchFavoritesLocations', () {
    test('Should fetch favorite locations', () async {
      // arrange
      final locations = [
        const LocationModel(city: 'city1', country: 'country1'),
        const LocationModel(city: 'city2', country: 'country2'),
      ];

      when(localStorage.read<Map<String, dynamic>>('favorite-locations')).thenAnswer(
          (_) async => {'locations': locations.map((e) => '${e.city}/${e.country}').toList()});

      // act
      final result = await datasource.fetchFavoritesLocations();

      // assert
      expect(result, locations);
    });

    test('Should return empty list when there is no favorite locations', () async {
      // arrange
      when(localStorage.read<Map<String, dynamic>>('favorite-locations'))
          .thenAnswer((_) async => null);

      // act
      final result = await datasource.fetchFavoritesLocations();

      // assert
      expect(result, []);
    });

    test('Should throw FetchFavoriteLocationsException when an error occurs', () async {
      // arrange
      when(localStorage.read<Map<String, dynamic>>('favorite-locations')).thenThrow(Exception());

      // act
      final call = datasource.fetchFavoritesLocations();

      // assert
      expect(call, throwsA(isA<FetchFavoriteLocationsException>()));
      verify(loggerService.error(any, stackTrace: anyNamed('stackTrace'))).called(1);
    });
  });

  group('fetchFavoriteLocationDetailed', () {
    const location = LocationModel(city: 'city', country: 'country');

    test('Should fetch favorite location detailed', () async {
      // arrange
      const weather = WeatherForecastModel(
        latitude: 0,
        longitude: 0,
        timezone: 'America/Sao_Paulo',
        timezoneAbbreviation: 'GMT-3',
        elevation: 0,
        daily: [],
      );

      when(localStorage.read<Map<String, dynamic>>('${location.city}-${location.country}'))
          .thenAnswer((_) async => weather.toMap());

      // act
      final result = await datasource.fetchFavoriteLocationDetailed(location);

      // assert
      expect(result, weather);
    });

    test('Should return null when there is no favorite location detailed', () async {
      // arrange
      when(localStorage.read<Map<String, dynamic>>('${location.city}-${location.country}'))
          .thenAnswer((_) async => null);

      // act
      final result = await datasource.fetchFavoriteLocationDetailed(location);

      // assert
      expect(result, null);
    });

    test('Should throw FetchFavoriteLocationDetailedException when an error occurs', () async {
      // arrange
      when(localStorage.read<Map<String, dynamic>>('${location.city}-${location.country}'))
          .thenThrow(Exception());

      // act
      final call = datasource.fetchFavoriteLocationDetailed(location);

      // assert
      expect(call, throwsA(isA<FetchFavoriteLocationDetailedException>()));
      verify(loggerService.error(any, stackTrace: anyNamed('stackTrace'))).called(1);
    });
  });

  group('addFavoriteLocationWithWeather', () {
    const location = LocationModel(city: 'city', country: 'country');
    const weather = WeatherForecastModel(
      latitude: 0,
      longitude: 0,
      timezone: 'America/Sao_Paulo',
      timezoneAbbreviation: 'GMT-3',
      elevation: 0,
      daily: [],
    );

    test('Should add favorite location with weather', () async {
      // arrange
      final locations = [
        const LocationModel(city: 'city1', country: 'country1'),
        const LocationModel(city: 'city2', country: 'country2'),
      ];

      when(localStorage.read<Map<String, dynamic>>('favorite-locations')).thenAnswer(
          (_) async => {'locations': locations.map((e) => '${e.city}/${e.country}').toList()});

      // act
      await datasource.addFavoriteLocationWithWeather(location, weather);

      // assert
      verify(localStorage.write('favorite-locations', {
        'locations': [...locations, location].map((e) => '${e.city}/${e.country}').toList()
      })).called(1);
      verify(localStorage.write('${location.city}-${location.country}', weather.toMap())).called(1);
    });

    test('Should not add favorite location when it already exists', () async {
      // arrange
      final locations = [
        const LocationModel(city: 'city1', country: 'country1'),
        const LocationModel(city: 'city', country: 'country'),
      ];

      when(localStorage.read<Map<String, dynamic>>('favorite-locations')).thenAnswer(
          (_) async => {'locations': locations.map((e) => '${e.city}/${e.country}').toList()});

      // act
      await datasource.addFavoriteLocationWithWeather(location, weather);

      // assert
      verifyNever(localStorage.write('favorite-locations', any));
      verify(localStorage.write('${location.city}-${location.country}', weather.toMap())).called(1);
    });

    test('Should throw AddFavoriteLocationException when an error occurs', () async {
      // arrange
      when(localStorage.read<Map<String, dynamic>>('favorite-locations')).thenThrow(Exception());

      // act
      final call = datasource.addFavoriteLocationWithWeather(location, weather);

      // assert
      expect(call, throwsA(isA<AddFavoriteLocationException>()));
      verify(loggerService.error(any, stackTrace: anyNamed('stackTrace')));
    });
  });

  group('removeFavoriteLocation', () {
    const location = LocationModel(city: 'city', country: 'country');

    test('Should remove favorite location', () async {
      // arrange
      final locations = [
        const LocationModel(city: 'city1', country: 'country1'),
        const LocationModel(city: 'city', country: 'country'),
      ];

      when(localStorage.read<Map<String, dynamic>>('favorite-locations')).thenAnswer(
          (_) async => {'locations': locations.map((e) => '${e.city}/${e.country}').toList()});

      // act
      await datasource.removeFavoriteLocation(location);

      // assert
      verify(localStorage.write('favorite-locations', {
        'locations':
            locations.where((e) => e != location).map((e) => '${e.city}/${e.country}').toList()
      })).called(1);
      verify(localStorage.delete('${location.city}-${location.country}')).called(1);
    });

    test('Should throw RemoveFavoriteLocationException when an error occurs', () async {
      // arrange
      when(localStorage.read<Map<String, dynamic>>('favorite-locations')).thenThrow(Exception());

      // act
      final call = datasource.removeFavoriteLocation(location);

      // assert
      expect(call, throwsA(isA<RemoveFavoriteLocationException>()));
      verify(loggerService.error(any, stackTrace: anyNamed('stackTrace')));
    });
  });
}
