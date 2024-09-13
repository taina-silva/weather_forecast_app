// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationService on LocationServiceBase, Store {
  late final _$locationServiceStatusAtom =
      Atom(name: 'LocationServiceBase.locationServiceStatus', context: context);

  @override
  LocationServiceStatus get locationServiceStatus {
    _$locationServiceStatusAtom.reportRead();
    return super.locationServiceStatus;
  }

  @override
  set locationServiceStatus(LocationServiceStatus value) {
    _$locationServiceStatusAtom.reportWrite(value, super.locationServiceStatus,
        () {
      super.locationServiceStatus = value;
    });
  }

  late final _$locationPermissionStatusAtom = Atom(
      name: 'LocationServiceBase.locationPermissionStatus', context: context);

  @override
  LocationPermissionStatus get locationPermissionStatus {
    _$locationPermissionStatusAtom.reportRead();
    return super.locationPermissionStatus;
  }

  @override
  set locationPermissionStatus(LocationPermissionStatus value) {
    _$locationPermissionStatusAtom
        .reportWrite(value, super.locationPermissionStatus, () {
      super.locationPermissionStatus = value;
    });
  }

  late final _$lastKnownLocationAtom =
      Atom(name: 'LocationServiceBase.lastKnownLocation', context: context);

  @override
  LocationModel? get lastKnownLocation {
    _$lastKnownLocationAtom.reportRead();
    return super.lastKnownLocation;
  }

  @override
  set lastKnownLocation(LocationModel? value) {
    _$lastKnownLocationAtom.reportWrite(value, super.lastKnownLocation, () {
      super.lastKnownLocation = value;
    });
  }

  late final _$checkPermissionAsyncAction =
      AsyncAction('LocationServiceBase.checkPermission', context: context);

  @override
  Future<void> checkPermission() {
    return _$checkPermissionAsyncAction.run(() => super.checkPermission());
  }

  late final _$requestPermissionAsyncAction =
      AsyncAction('LocationServiceBase.requestPermission', context: context);

  @override
  Future<void> requestPermission() {
    return _$requestPermissionAsyncAction.run(() => super.requestPermission());
  }

  late final _$getCurrentLocationAsyncAction =
      AsyncAction('LocationServiceBase.getCurrentLocation', context: context);

  @override
  Future<LocationModel?> getCurrentLocation({bool forceFetch = false}) {
    return _$getCurrentLocationAsyncAction
        .run(() => super.getCurrentLocation(forceFetch: forceFetch));
  }

  late final _$getCityNameFromLocationAsyncAction = AsyncAction(
      'LocationServiceBase.getCityNameFromLocation',
      context: context);

  @override
  Future<Tuple2<String, String>?> getCityNameFromLocation(
      {LocationModel? location}) {
    return _$getCityNameFromLocationAsyncAction
        .run(() => super.getCityNameFromLocation(location: location));
  }

  @override
  String toString() {
    return '''
locationServiceStatus: ${locationServiceStatus},
locationPermissionStatus: ${locationPermissionStatus},
lastKnownLocation: ${lastKnownLocation}
    ''';
  }
}
