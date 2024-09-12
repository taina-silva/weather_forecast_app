// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CountriesService on CountriesServiceBase, Store {
  late final _$countriesAtom =
      Atom(name: 'CountriesServiceBase.countries', context: context);

  @override
  ObservableList<CountryModel> get countries {
    _$countriesAtom.reportRead();
    return super.countries;
  }

  @override
  set countries(ObservableList<CountryModel> value) {
    _$countriesAtom.reportWrite(value, super.countries, () {
      super.countries = value;
    });
  }

  @override
  String toString() {
    return '''
countries: ${countries}
    ''';
  }
}
