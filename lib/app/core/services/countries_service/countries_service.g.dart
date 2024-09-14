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

  late final _$_fetchCountriesAsyncAction =
      AsyncAction('CountriesServiceBase._fetchCountries', context: context);

  @override
  Future<void> _fetchCountries() {
    return _$_fetchCountriesAsyncAction.run(() => super._fetchCountries());
  }

  @override
  String toString() {
    return '''
countries: ${countries}
    ''';
  }
}
