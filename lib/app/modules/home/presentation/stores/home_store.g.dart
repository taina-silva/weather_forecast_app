// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$countriesAtom =
      Atom(name: 'HomeStoreBase.countries', context: context);

  @override
  List<String> get countries {
    _$countriesAtom.reportRead();
    return super.countries;
  }

  @override
  set countries(List<String> value) {
    _$countriesAtom.reportWrite(value, super.countries, () {
      super.countries = value;
    });
  }

  late final _$citiesAtom =
      Atom(name: 'HomeStoreBase.cities', context: context);

  @override
  List<String> get cities {
    _$citiesAtom.reportRead();
    return super.cities;
  }

  @override
  set cities(List<String> value) {
    _$citiesAtom.reportWrite(value, super.cities, () {
      super.cities = value;
    });
  }

  late final _$selectedCountryAtom =
      Atom(name: 'HomeStoreBase.selectedCountry', context: context);

  @override
  String? get selectedCountry {
    _$selectedCountryAtom.reportRead();
    return super.selectedCountry;
  }

  @override
  set selectedCountry(String? value) {
    _$selectedCountryAtom.reportWrite(value, super.selectedCountry, () {
      super.selectedCountry = value;
    });
  }

  late final _$selectedCityAtom =
      Atom(name: 'HomeStoreBase.selectedCity', context: context);

  @override
  String? get selectedCity {
    _$selectedCityAtom.reportRead();
    return super.selectedCity;
  }

  @override
  set selectedCity(String? value) {
    _$selectedCityAtom.reportWrite(value, super.selectedCity, () {
      super.selectedCity = value;
    });
  }

  late final _$searchCountryAtom =
      Atom(name: 'HomeStoreBase.searchCountry', context: context);

  @override
  String get searchCountry {
    _$searchCountryAtom.reportRead();
    return super.searchCountry;
  }

  @override
  set searchCountry(String value) {
    _$searchCountryAtom.reportWrite(value, super.searchCountry, () {
      super.searchCountry = value;
    });
  }

  late final _$searchCityAtom =
      Atom(name: 'HomeStoreBase.searchCity', context: context);

  @override
  String get searchCity {
    _$searchCityAtom.reportRead();
    return super.searchCity;
  }

  @override
  set searchCity(String value) {
    _$searchCityAtom.reportWrite(value, super.searchCity, () {
      super.searchCity = value;
    });
  }

  late final _$getCountriesStateAtom =
      Atom(name: 'HomeStoreBase.getCountriesState', context: context);

  @override
  GetCountriesState get getCountriesState {
    _$getCountriesStateAtom.reportRead();
    return super.getCountriesState;
  }

  @override
  set getCountriesState(GetCountriesState value) {
    _$getCountriesStateAtom.reportWrite(value, super.getCountriesState, () {
      super.getCountriesState = value;
    });
  }

  late final _$getCitiesStateAtom =
      Atom(name: 'HomeStoreBase.getCitiesState', context: context);

  @override
  GetCitiesState get getCitiesState {
    _$getCitiesStateAtom.reportRead();
    return super.getCitiesState;
  }

  @override
  set getCitiesState(GetCitiesState value) {
    _$getCitiesStateAtom.reportWrite(value, super.getCitiesState, () {
      super.getCitiesState = value;
    });
  }

  late final _$getCountriesAsyncAction =
      AsyncAction('HomeStoreBase.getCountries', context: context);

  @override
  Future<void> getCountries() {
    return _$getCountriesAsyncAction.run(() => super.getCountries());
  }

  late final _$getCitiesAsyncAction =
      AsyncAction('HomeStoreBase.getCities', context: context);

  @override
  Future<void> getCities({String? search}) {
    return _$getCitiesAsyncAction.run(() => super.getCities(search: search));
  }

  @override
  String toString() {
    return '''
countries: ${countries},
cities: ${cities},
selectedCountry: ${selectedCountry},
selectedCity: ${selectedCity},
searchCountry: ${searchCountry},
searchCity: ${searchCity},
getCountriesState: ${getCountriesState},
getCitiesState: ${getCitiesState}
    ''';
  }
}
