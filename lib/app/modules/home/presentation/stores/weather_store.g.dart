// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WeatherStore on WeatherStoreBase, Store {
  late final _$stateAtom =
      Atom(name: 'WeatherStoreBase.state', context: context);

  @override
  GetWeatherState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(GetWeatherState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$fetchWeatherAsyncAction =
      AsyncAction('WeatherStoreBase.fetchWeather', context: context);

  @override
  Future<void> fetchWeather(LocationModel location) {
    return _$fetchWeatherAsyncAction.run(() => super.fetchWeather(location));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
