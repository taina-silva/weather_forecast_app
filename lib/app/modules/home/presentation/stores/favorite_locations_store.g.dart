// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_locations_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteLocationsStore on FavoriteLocationsStoreBase, Store {
  late final _$getFavoriteLocationsStateAtom = Atom(
      name: 'FavoriteLocationsStoreBase.getFavoriteLocationsState',
      context: context);

  @override
  GetFavoriteLocationsState get getFavoriteLocationsState {
    _$getFavoriteLocationsStateAtom.reportRead();
    return super.getFavoriteLocationsState;
  }

  @override
  set getFavoriteLocationsState(GetFavoriteLocationsState value) {
    _$getFavoriteLocationsStateAtom
        .reportWrite(value, super.getFavoriteLocationsState, () {
      super.getFavoriteLocationsState = value;
    });
  }

  late final _$manipulateFavoriteLocationStateAtom = Atom(
      name: 'FavoriteLocationsStoreBase.manipulateFavoriteLocationState',
      context: context);

  @override
  ManipulateFavoriteLocationState get manipulateFavoriteLocationState {
    _$manipulateFavoriteLocationStateAtom.reportRead();
    return super.manipulateFavoriteLocationState;
  }

  @override
  set manipulateFavoriteLocationState(ManipulateFavoriteLocationState value) {
    _$manipulateFavoriteLocationStateAtom
        .reportWrite(value, super.manipulateFavoriteLocationState, () {
      super.manipulateFavoriteLocationState = value;
    });
  }

  late final _$favoriteLocationsAtom = Atom(
      name: 'FavoriteLocationsStoreBase.favoriteLocations', context: context);

  @override
  ObservableList<LocationModel> get favoriteLocations {
    _$favoriteLocationsAtom.reportRead();
    return super.favoriteLocations;
  }

  @override
  set favoriteLocations(ObservableList<LocationModel> value) {
    _$favoriteLocationsAtom.reportWrite(value, super.favoriteLocations, () {
      super.favoriteLocations = value;
    });
  }

  late final _$getFavoriteLocationsAsyncAction = AsyncAction(
      'FavoriteLocationsStoreBase.getFavoriteLocations',
      context: context);

  @override
  Future<void> getFavoriteLocations() {
    return _$getFavoriteLocationsAsyncAction
        .run(() => super.getFavoriteLocations());
  }

  late final _$addFavoriteLocationAsyncAction = AsyncAction(
      'FavoriteLocationsStoreBase.addFavoriteLocation',
      context: context);

  @override
  Future<void> addFavoriteLocation(
      LocationModel location, WeatherForecastModel weather) {
    return _$addFavoriteLocationAsyncAction
        .run(() => super.addFavoriteLocation(location, weather));
  }

  late final _$removeFavoriteLocationAsyncAction = AsyncAction(
      'FavoriteLocationsStoreBase.removeFavoriteLocation',
      context: context);

  @override
  Future<void> removeFavoriteLocation(LocationModel location) {
    return _$removeFavoriteLocationAsyncAction
        .run(() => super.removeFavoriteLocation(location));
  }

  @override
  String toString() {
    return '''
getFavoriteLocationsState: ${getFavoriteLocationsState},
manipulateFavoriteLocationState: ${manipulateFavoriteLocationState},
favoriteLocations: ${favoriteLocations}
    ''';
  }
}
