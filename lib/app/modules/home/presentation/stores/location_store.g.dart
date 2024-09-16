// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationStore on LocationStoreBase, Store {
  late final _$getCountriesStateAtom =
      Atom(name: 'LocationStoreBase.getCountriesState', context: context);

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
      Atom(name: 'LocationStoreBase.getCitiesState', context: context);

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

  late final _$_selectedCountryAtom =
      Atom(name: 'LocationStoreBase._selectedCountry', context: context);

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
      Atom(name: 'LocationStoreBase._selectedCity', context: context);

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

  late final _$fetchCountriesAsyncAction =
      AsyncAction('LocationStoreBase.fetchCountries', context: context);

  @override
  Future<void> fetchCountries(String? search) {
    return _$fetchCountriesAsyncAction.run(() => super.fetchCountries(search));
  }

  late final _$fetchCitiesAsyncAction =
      AsyncAction('LocationStoreBase.fetchCities', context: context);

  @override
  Future<void> fetchCities(String? search) {
    return _$fetchCitiesAsyncAction.run(() => super.fetchCities(search));
  }

  late final _$LocationStoreBaseActionController =
      ActionController(name: 'LocationStoreBase', context: context);

  @override
  void setSelectedCountry(CountryModel? country) {
    final _$actionInfo = _$LocationStoreBaseActionController.startAction(
        name: 'LocationStoreBase.setSelectedCountry');
    try {
      return super.setSelectedCountry(country);
    } finally {
      _$LocationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCity(String? city) {
    final _$actionInfo = _$LocationStoreBaseActionController.startAction(
        name: 'LocationStoreBase.setSelectedCity');
    try {
      return super.setSelectedCity(city);
    } finally {
      _$LocationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCountryAndCity(LocationModel location) {
    final _$actionInfo = _$LocationStoreBaseActionController.startAction(
        name: 'LocationStoreBase.setCountryAndCity');
    try {
      return super.setCountryAndCity(location);
    } finally {
      _$LocationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
getCountriesState: ${getCountriesState},
getCitiesState: ${getCitiesState}
    ''';
  }
}
