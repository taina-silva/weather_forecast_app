import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/errors/exceptions.dart';
import 'package:weather_forecast_app/app/core/models/country/country_model.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/position/position_model.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/countries_service.dart';
import 'package:weather_forecast_app/app/core/services/location_service/location_service.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/location_states.dart';

part 'location_store.g.dart';

class LocationStore = LocationStoreBase with _$LocationStore;

abstract class LocationStoreBase with Store {
  final CountriesService _countriesService;
  final LocationService _locationService;

  LocationStoreBase(this._countriesService, this._locationService) {
    initLocationSubscription();
  }

  void initLocationSubscription() {
    _locationService.lastKnownPosition.listen((PositionModel? location) async {
      if (location != null && _selectedCity == null) {
        final result = await _locationService.getLocationFromPosition(location);
        if (result != null) setCountryAndCity(result);
      }
    });
  }

  @observable
  GetCountriesState getCountriesState = GetCountriesInitialState();

  @observable
  GetCitiesState getCitiesState = GetCitiesInitialState();

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
  void setCountryAndCity(LocationModel location) {
    var country = _countriesService.countryFromName(location.country);
    country ??= CountryModel(name: location.country, cities: const []);
    _selectedCountry = country;
    _selectedCity = location.city;
  }

  @action
  Future<void> fetchCountries(String? search) async {
    getCountriesState = GetCountriesLoadingState();

    try {
      final countries = await _countriesService.getCountries(search: search);
      getCountriesState = GetCountriesSuccessState(countries);
    } on NoConnectionException {
      getCountriesState = GetCountriesNoConnectionState();
    } catch (error) {
      getCountriesState = GetCountriesErrorState(error.toString());
    }
  }

  @action
  Future<void> fetchCities(String? search) async {
    getCitiesState = GetCitiesLoadingState();

    if (_selectedCountry == null) {
      getCitiesState = GetCitiesSuccessState(const []);
      return;
    }

    try {
      if (search == null) {
        await _handleNoSearch();
        return;
      }

      final cities = await _countriesService.getCities(_selectedCountry!, search: search);
      cities.isEmpty ? await _handleNoSearch() : getCitiesState = GetCitiesSuccessState(cities);
    } on NoConnectionException {
      getCitiesState = GetCitiesNoConnectionState();
    } catch (error) {
      getCitiesState = GetCitiesErrorState(error.toString());
    }
  }

  Future<void> _handleNoSearch() async {
    if (_selectedCountry!.cities.isNotEmpty) {
      getCitiesState = GetCitiesSuccessState(_selectedCountry!.cities);
    } else {
      await _countriesService.getCountries();
      _selectedCountry = _countriesService.countryFromName(_selectedCountry!.name);
      getCitiesState = GetCitiesSuccessState(_selectedCountry!.cities);
    }
  }
}
