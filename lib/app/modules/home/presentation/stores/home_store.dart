import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/countries_service.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/models/country_model.dart';
import 'package:weather_forecast_app/app/core/services/location_service/location_service.dart';
import 'package:weather_forecast_app/app/core/services/location_service/models/location_model.dart';
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
      reaction((_) => searchCountry, (String text) => getCountries()),
      reaction((_) => searchCity, (String text) => getCities()),
      reaction((_) => selectedCountry, (String? country) {
        if (country != null) {
          final CountryModel? countryModel = _countriesService.countryFromName(selectedCountry!);
          if (countryModel != null) cities = countryModel.cities;
        }
      }),
    ];
  }

  void initLocationSubscription() {
    _locationService.lastKnownLocation.listen((LocationModel? location) async {
      if (location != null && selectedCity == null) {
        final result = await _locationService.getCityNameFromLocation(location);

        if (result != null) {
          selectedCity = result.item1;
          selectedCountry = result.item2;
        }
      }
    });
  }

  @observable
  List<String> countries = [];

  @observable
  List<String> cities = [];

  @observable
  String? selectedCountry;

  @observable
  String? selectedCity;

  @observable
  String searchCountry = '';

  @observable
  String searchCity = '';

  @observable
  GetCountriesState getCountriesState = GetCountriesInitialState();

  @observable
  GetCitiesState getCitiesState = GetCitiesInitialState();

  @action
  Future<void> getCountries() async {
    getCountriesState = GetCountriesLoadingState();

    try {
      countries = await _countriesService.countriesNames();
      getCountriesState = GetCountriesSuccessState();
    } catch (error) {
      getCountriesState = GetCountriesErrorState(error.toString());
    }
  }

  @action
  Future<void> getCities({String? search}) async {
    if (selectedCountry == null) return;

    getCitiesState = GetCitiesLoadingState();

    try {
      CountryModel? country = _countriesService.countryFromName(selectedCountry!);

      if (country == null) {
        getCitiesState = GetCitiesErrorState('Country not found');
        return;
      }

      cities = await _countriesService.citiesNames(country, search: search);
      getCitiesState = GetCitiesSuccessState();
    } catch (error) {
      getCitiesState = GetCitiesErrorState(error.toString());
    }
  }
}
