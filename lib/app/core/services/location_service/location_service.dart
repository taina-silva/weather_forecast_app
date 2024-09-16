import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/position/position_model.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';

enum LocationServiceStatus { enabled, disabled }

enum LocationPermissionStatus { granted, denied }

abstract class LocationService {
  LocationServiceStatus locationServiceStatus = LocationServiceStatus.disabled;
  LocationPermissionStatus locationPermissionStatus = LocationPermissionStatus.denied;
  Stream<PositionModel?> get lastKnownPosition;
  Future<void> checkPermission();
  Future<void> requestPermission();
  Future<PositionModel?> getCurrentLocation();
  Future<LocationModel?> getLocationFromPosition(PositionModel position);
}

class LocationServiceImpl implements LocationService {
  LocationServiceImpl._singleton();
  static final LocationServiceImpl instance = LocationServiceImpl._singleton();

  late LoggerService _loggerService;

  factory LocationServiceImpl(LoggerService loggerService) {
    instance._loggerService = loggerService;
    instance.requestPermission();

    return instance;
  }

  @override
  LocationServiceStatus locationServiceStatus = LocationServiceStatus.disabled;

  @override
  LocationPermissionStatus locationPermissionStatus = LocationPermissionStatus.denied;

  final StreamController<PositionModel?> _lastKnownPositionStreamController =
      StreamController<PositionModel?>.broadcast();

  @override
  Stream<PositionModel?> get lastKnownPosition => _lastKnownPositionStreamController.stream;

  @override
  Future<void> checkPermission() async {
    final permission = await _handlePermission(Geolocator.checkPermission);
    locationPermissionStatus = permission;
  }

  @override
  Future<void> requestPermission() async {
    final permission = await _handlePermission(Geolocator.requestPermission);
    locationPermissionStatus = permission;
  }

  Future<LocationPermissionStatus> _handlePermission(
      Future<LocationPermission> Function() permissionCheck) async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) return LocationPermissionStatus.denied;

      final result = await permissionCheck();

      if (result == LocationPermission.always || result == LocationPermission.whileInUse) {
        await getCurrentLocation();
        return LocationPermissionStatus.granted;
      } else {
        return LocationPermissionStatus.denied;
      }
    } catch (error, stackTrace) {
      _loggerService.error('Error handling location permission: $error', stackTrace: stackTrace);
      return LocationPermissionStatus.denied;
    }
  }

  @override
  Future<PositionModel?> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      final positionModel =
          PositionModel(latitude: position.latitude, longitude: position.longitude);
      _lastKnownPositionStreamController.add(positionModel);
      return positionModel;
    } catch (error, stackTrace) {
      if (error is PermissionDeniedException) {
        requestPermission();
      } else {
        _loggerService.error('Error getting current location: $error', stackTrace: stackTrace);
      }
    }

    return null;
  }

  @override
  Future<LocationModel?> getLocationFromPosition(PositionModel position) async {
    try {
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isEmpty) return null;

      if(placemarks.first.subAdministrativeArea == null || placemarks.first.country == null) {
        return null;
      }

      return LocationModel(
          city: placemarks.first.subAdministrativeArea!, country: placemarks.first.country!);
    } catch (error, stackTrace) {
      _loggerService.error('Error getting city name from location: $error', stackTrace: stackTrace);
    }

    return null;
  }
}
