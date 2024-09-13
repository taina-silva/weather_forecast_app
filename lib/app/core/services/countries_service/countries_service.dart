import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/models/country_model.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/core/utils/strings.dart';

part 'countries_service.g.dart';

class CountriesService = CountriesServiceBase with _$CountriesService;

abstract class CountriesServiceBase with Store {
  final LoggerService _loggerService;
  final String jsonPath = '${Assets.jsons}/locations.json';

  CountriesServiceBase(this._loggerService) {
    fetchCountries();
  }

  @observable
  ObservableList<CountryModel> countries = ObservableList<CountryModel>();

  Future<void> fetchCountries() async {
    try {
      final jsonString = await rootBundle.loadString(jsonPath);
      final data = json.decode(jsonString);
      final list = (data["data"] as List).map((country) => CountryModel.fromMap(country)).toList();

      countries = list.asObservable();
    } catch (error, stackTrace) {
      _loggerService.logError('Error fetching countries: $error', stackTrace: stackTrace);
    }
  }

  CountryModel? countryFromName(String name) {
    try {
      return countries.firstWhere(
          (country) => capitalizeAndNoDiacritics(country.name) == capitalizeAndNoDiacritics(name));
    } catch (error) {
      return null;
    }
  }

  List<String> countriesNamesBySearch(String search) {
    String text = capitalizeAndNoDiacritics(search);
    return countries
        .where((country) => capitalizeAndNoDiacritics(country.name).contains(text))
        .map((country) => capitalizeAndNoDiacritics(country.name))
        .toList();
  }

  List<String> citiesNamesBySearch(CountryModel country, String search) {
    String text = capitalizeAndNoDiacritics(search);
    return country.cities.where((city) => capitalizeAndNoDiacritics(city).contains(text)).toList();
  }
}
