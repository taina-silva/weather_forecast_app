import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/countries_service.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/models/country_model.dart';
import 'package:weather_forecast_app/app/core/services/location_service/location_service.dart';
import 'package:weather_forecast_app/app/core/services/location_service/models/position_model.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/home_states.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final CountriesService _countriesService;
  final LocationService _locationService;

  List<ReactionDisposer> reactions = [];

  HomeStoreBase(this._countriesService, this._locationService) {
    initLocationSubscription();

    reactions = [
      // reaction((_) => searchCountry, (String text) => getCountries(text)),
      // reaction((_) => searchCity, (String text) => getCities(text)),
      reaction((_) => _selectedCountry, (CountryModel? country) {
        if (country != null) cities = country.cities;
      }),
    ];
  }

  void initLocationSubscription() {
    _locationService.lastKnownPosition.listen((PositionModel? location) async {
      if (location != null && _selectedCity == null) {
        final result = await _locationService.getLocationFromPosition(location);

        if (result != null) {
          _selectedCity = result.item1;
          _selectedCountry = _countriesService.countryFromName(result.item2);
        }
      }
    });
  }

  @observable
  GetCountriesState getCountriesState = GetCountriesInitialState();

  @observable
  GetCitiesState getCitiesState = GetCitiesInitialState();

  @observable
  List<CountryModel> countries = [];

  @observable
  List<String> cities = [];

  @readonly
  CountryModel? _selectedCountry;

  @readonly
  String? _selectedCity;

  @action
  void setSelectedCountry(CountryModel? country) {
    setSelectedCity(null);
    _selectedCountry = country;
  }

  @action
  void setSelectedCity(String? city) {
    _selectedCity = city;
  }

  @action
  Future<List<CountryModel>> getCountries(String? search) async {
    getCountriesState = GetCountriesLoadingState();

    try {
      countries = await _countriesService.getCountries(search: search);
      getCountriesState = GetCountriesSuccessState();
      return countries;
    } catch (error) {
      getCountriesState = GetCountriesErrorState(error.toString());
    }

    return [];
  }

  @action
  Future<List<String>> getCities(String? search) async {
    if (_selectedCountry == null) return [];

    getCitiesState = GetCitiesLoadingState();

    try {
      cities = await _countriesService.getCities(_selectedCountry!, search: search);
      getCitiesState = GetCitiesSuccessState();
      return cities;
    } catch (error) {
      getCitiesState = GetCitiesErrorState(error.toString());
    }

    return [];
  }
}
