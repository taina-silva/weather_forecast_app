import 'package:weather_forecast_app/app/core/services/countries_service/models/country_model.dart';

class ComputeModel {
  final String jsonPath;
  final CountryModel Function(Map<String, dynamic>) fromMap;

  ComputeModel(this.jsonPath, this.fromMap);
}
