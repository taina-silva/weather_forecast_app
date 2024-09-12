import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/models/compute_model.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/models/country_model.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/utils/compute.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';

part 'countries_service.g.dart';

class CountriesService = CountriesServiceBase with _$CountriesService;

abstract class CountriesServiceBase with Store {
  final LoggerServiceImpl _loggerService;
  final String jsonPath = '${Assets.jsons}/Countries.json';

  CountriesServiceBase(this._loggerService) {
    compute<ComputeModel, List<CountryModel>>(
      computeCountries,
      ComputeModel(jsonPath, (map) => CountryModel.fromMap(map)),
    ).then(
      (countries) {
        countries = countries.asObservable();
      },
    ).catchError((error) {
      _loggerService.logError(error);
    });
  }

  @observable
  ObservableList<CountryModel> countries = ObservableList<CountryModel>();

  List<String> countriesWithSearch(String search) {
    return countries
        .where((country) => country.name.contains(search))
        .map((country) => country.name)
        .toList();
  }

  List<String> citiesWithSearch(CountryModel country, String search) {
    return country.cities.where((city) => city.contains(search)).toList();
  }
}
