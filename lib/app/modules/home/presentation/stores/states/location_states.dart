import 'package:weather_forecast_app/app/core/models/country/country_model.dart';
import 'package:weather_forecast_app/app/core/states/general_state.dart';

class GetCountriesState extends GeneralState<List<CountryModel>> {}

class GetCountriesInitialState extends GeneralInitialState<List<CountryModel>>
    implements GetCountriesState {}

class GetCountriesLoadingState extends GeneralLoadingState<List<CountryModel>>
    implements GetCountriesState {}

class GetCountriesNoConnectionState extends GeneralNoConnectionState<List<CountryModel>>
    implements GetCountriesState {}

class GetCountriesSuccessState extends GeneralSuccessWithDataState<List<CountryModel>>
    implements GetCountriesState {
  final List<CountryModel> countries;
  GetCountriesSuccessState(this.countries) : super(countries);
}

class GetCountriesErrorState extends GeneralErrorState<List<CountryModel>>
    implements GetCountriesState {
  @override
  final String message;
  GetCountriesErrorState(this.message) : super(message);
}

class GetCitiesState extends GeneralState<List<String>> {}

class GetCitiesInitialState extends GeneralInitialState<List<String>> implements GetCitiesState {}

class GetCitiesLoadingState extends GeneralLoadingState<List<String>> implements GetCitiesState {}

class GetCitiesNoConnectionState extends GeneralNoConnectionState<List<String>>
    implements GetCitiesState {}

class GetCitiesSuccessState extends GeneralSuccessWithDataState<List<String>>
    implements GetCitiesState {
  final List<String> cities;
  GetCitiesSuccessState(this.cities) : super(cities);
}

class GetCitiesErrorState extends GeneralErrorState<List<String>> implements GetCitiesState {
  @override
  final String message;
  GetCitiesErrorState(this.message) : super(message);
}
