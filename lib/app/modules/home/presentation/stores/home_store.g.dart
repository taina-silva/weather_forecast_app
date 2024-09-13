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
  ObservableList<String> get countries {
    _$countriesAtom.reportRead();
    return super.countries;
  }

  @override
  set countries(ObservableList<String> value) {
    _$countriesAtom.reportWrite(value, super.countries, () {
      super.countries = value;
    });
  }

  late final _$citiesAtom =
      Atom(name: 'HomeStoreBase.cities', context: context);

  @override
  ObservableList<String> get cities {
    _$citiesAtom.reportRead();
    return super.cities;
  }

  @override
  set cities(ObservableList<String> value) {
    _$citiesAtom.reportWrite(value, super.cities, () {
      super.cities = value;
    });
  }

  late final _$selectedCountryAtom =
      Atom(name: 'HomeStoreBase.selectedCountry', context: context);

  @override
  CountryModel? get selectedCountry {
    _$selectedCountryAtom.reportRead();
    return super.selectedCountry;
  }

  @override
  set selectedCountry(CountryModel? value) {
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

  @override
  String toString() {
    return '''
countries: ${countries},
cities: ${cities},
selectedCountry: ${selectedCountry},
selectedCity: ${selectedCity},
searchCountry: ${searchCountry},
searchCity: ${searchCity}
    ''';
  }
}
