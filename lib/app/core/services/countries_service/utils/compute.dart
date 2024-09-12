import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/models/compute_model.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/models/country_model.dart';

Future<List<CountryModel>> computeCountries(ComputeModel compute) async {
  try {
    final jsonString = await rootBundle.loadString(compute.jsonPath);
    final country = json.decode(jsonString) as List;

    return country.map((country) => compute.fromMap(country)).toList();
  } catch (error) {
    rethrow;
  }
}
