import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/models/country/country_model.dart';
import 'package:weather_forecast_app/app/core/models/position/position_model.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/countries_service.dart';
import 'package:weather_forecast_app/app/core/services/location_service/location_service.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/location_states.dart';

part 'location_store.g.dart';

class LocationStore = LocationStoreBase with _$LocationStore;

abstract class LocationStoreBase with Store {
  final CountriesService _countriesService;
  final LocationService _locationService;

  List<ReactionDisposer> reactions = [];

  LocationStoreBase(this._countriesService, this._locationService) {
    initLocationSubscription();

    reactions = [
      reaction(
        (_) => _selectedCountry,
        (CountryModel? country) {
          if (country != null) getCities(null);
        },
      ),
    ];
  }

  void initLocationSubscription() {
    _locationService.lastKnownPosition.listen((PositionModel? location) async {
      if (location != null && _selectedCity == null) {
        final result = await _locationService.getLocationFromPosition(location);

        if (result != null) {
          _selectedCountry = _countriesService.countryFromName(result.country);
          _selectedCity = result.city;
        }
      }
    });
  }

  @observable
  GetLocationsState getCountriesState = GetLocationsInitialState();

  @observable
  GetLocationsState getCitiesState = GetLocationsInitialState();

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
  Future<void> getCountries(String? search) async {
    getCountriesState = GetLocationsLoadingState();

    try {
      countries = await _countriesService.getCountries(search: search);
      getCountriesState = GetLocationsSuccessState();
    } catch (error) {
      getCountriesState = GetLocationsErrorState(error.toString());
    }
  }

  @action
  Future<void> getCities(String? search) async {
    getCitiesState = GetLocationsLoadingState();

    try {
      if (_selectedCountry == null) {
        getCitiesState = GetLocationsSuccessState();
        return;
      }

      if (search == null) {
        getCitiesState = GetLocationsSuccessState();
        cities = _selectedCountry!.cities;
        return;
      }

      cities = await _countriesService.getCities(_selectedCountry!, search: search);
      getCitiesState = GetLocationsSuccessState();
    } catch (error) {
      getCitiesState = GetLocationsErrorState(error.toString());
    }
  }
}
