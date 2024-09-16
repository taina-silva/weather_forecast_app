import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/models/country/country_model.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/core/utils/strings.dart';

abstract class CountriesService {
  CountryModel? countryFromName(String name);
  Future<List<CountryModel>> getCountries({String? search});
  Future<List<String>> getCities(CountryModel country, {String? search});
}

class CountriesServiceImpl implements CountriesService {
  final LoggerService _loggerService;
  final String jsonPath = '${Assets.jsons}/locations.json';

  List<CountryModel> countries = [];

  CountriesServiceImpl(this._loggerService) {
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    try {
      final jsonString = await rootBundle.loadString(jsonPath);
      final data = json.decode(jsonString);
      final list = (data["data"] as List).map((country) => CountryModel.fromMap(country)).toList();

      countries = list.asObservable();
    } catch (error, stackTrace) {
      _loggerService.error('Error fetching countries: $error', stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  CountryModel? countryFromName(String name) {
    try {
      return countries.firstWhere(
          (country) => capitalizeAndNoDiacritics(country.name) == capitalizeAndNoDiacritics(name));
    } catch (error) {
      return null;
    }
  }

  @override
  Future<List<CountryModel>> getCountries({String? search}) async {
    try {
      String? text;

      if (search != null) text = capitalizeAndNoDiacritics(search);
      if (countries.isEmpty) await _fetchCountries();

      return countries
          .where((country) => capitalizeAndNoDiacritics(country.name).contains(text ?? ''))
          .toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getCities(CountryModel country, {String? search}) async {
    try {
      String? text;

      if (search != null) text = capitalizeAndNoDiacritics(search);

      return country.cities
          .where((city) => capitalizeAndNoDiacritics(city).contains(text ?? ''))
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}
