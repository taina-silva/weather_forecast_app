// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
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

  late final _$countriesAtom =
      Atom(name: 'HomeStoreBase.countries', context: context);

  @override
  List<CountryModel> get countries {
    _$countriesAtom.reportRead();
    return super.countries;
  }

  @override
  set countries(List<CountryModel> value) {
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

  late final _$_selectedCountryAtom =
      Atom(name: 'HomeStoreBase._selectedCountry', context: context);

  CountryModel? get selectedCountry {
    _$_selectedCountryAtom.reportRead();
    return super._selectedCountry;
  }

  @override
  CountryModel? get _selectedCountry => selectedCountry;

  @override
  set _selectedCountry(CountryModel? value) {
    _$_selectedCountryAtom.reportWrite(value, super._selectedCountry, () {
      super._selectedCountry = value;
    });
  }

  late final _$_selectedCityAtom =
      Atom(name: 'HomeStoreBase._selectedCity', context: context);

  String? get selectedCity {
    _$_selectedCityAtom.reportRead();
    return super._selectedCity;
  }

  @override
  String? get _selectedCity => selectedCity;

  @override
  set _selectedCity(String? value) {
    _$_selectedCityAtom.reportWrite(value, super._selectedCity, () {
      super._selectedCity = value;
    });
  }

  late final _$getCountriesAsyncAction =
      AsyncAction('HomeStoreBase.getCountries', context: context);

  @override
  Future<List<CountryModel>> getCountries(String? search) {
    return _$getCountriesAsyncAction.run(() => super.getCountries(search));
  }

  late final _$getCitiesAsyncAction =
      AsyncAction('HomeStoreBase.getCities', context: context);

  @override
  Future<List<String>> getCities(String? search) {
    return _$getCitiesAsyncAction.run(() => super.getCities(search));
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  void setSelectedCountry(CountryModel? country) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setSelectedCountry');
    try {
      return super.setSelectedCountry(country);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCity(String? city) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setSelectedCity');
    try {
      return super.setSelectedCity(city);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
getCountriesState: ${getCountriesState},
getCitiesState: ${getCitiesState},
countries: ${countries},
cities: ${cities}
    ''';
  }
}
