import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/countries_service.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/models/country_model.dart';
import 'package:weather_forecast_app/app/core/services/location_service/location_service.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final CountriesService _countriesService;
  final LocationService _locationService;

  List<ReactionDisposer> reactions = [];

  HomeStoreBase(this._countriesService, this._locationService) {
    reactions = [
      reaction((_) => searchCountry, (String text) {
        countries = _countriesService.countriesWithSearch(text).asObservable();
      }),
      reaction((_) => searchCity, (String text) {
        cities = _countriesService.citiesWithSearch(selectedCountry!, text).asObservable();
      }),
      reaction((_) => selectedCountry, (CountryModel? country) {
        cities = country != null ? country.cities.asObservable() : ObservableList<String>();
      }),
    ];
  }

  @observable
  ObservableList<String> countries = ObservableList<String>();

  @observable
  ObservableList<String> cities = ObservableList<String>();

  @observable
  String searchCountry = '';

  @observable
  String searchCity = '';

  @observable
  CountryModel? selectedCountry;

  @observable
  String? selectedCity;
}
