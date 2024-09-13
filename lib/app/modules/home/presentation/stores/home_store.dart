import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/countries_service.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/models/country_model.dart';
import 'package:weather_forecast_app/app/core/services/location_service/location_service.dart';
import 'package:weather_forecast_app/app/core/services/location_service/models/location_model.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final CountriesService _countriesService;
  final LocationService _locationService;

  List<ReactionDisposer> reactions = [];

  HomeStoreBase(this._countriesService, this._locationService) {
    reactions = [
      reaction((_) => searchCountry, (String text) {
        countries = _countriesService.countriesNamesBySearch(text).asObservable();
      }),
      reaction((_) => searchCity, (String text) {
        cities = _countriesService.citiesNamesBySearch(selectedCountry!, text).asObservable();
      }),
      reaction((_) => selectedCountry, (CountryModel? country) {
        if (country != null) cities = country.cities.asObservable();
      }),
      reaction((_) => _locationService.lastKnownLocation, (LocationModel? location) async {
        if (location != null && selectedCity == null) {
          final result = await _locationService.getCityNameFromLocation();

          if (result != null) {
            selectedCity = result.item1;
            selectedCountry = _countriesService.countryFromName(result.item2);
          }
        }
      }),
    ];
  }

  @observable
  ObservableList<String> countries = ObservableList<String>();

  @observable
  ObservableList<String> cities = ObservableList<String>();

  @observable
  CountryModel? selectedCountry;

  @observable
  String? selectedCity;

  @observable
  String searchCountry = '';

  @observable
  String searchCity = '';
}
