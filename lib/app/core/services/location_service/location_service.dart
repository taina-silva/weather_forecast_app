import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_forecast_app/app/core/services/location_service/models/position_model.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';

enum LocationServiceStatus { enabled, disabled }

enum LocationPermissionStatus { granted, denied }

class LocationService {
  LocationService._singleton();
  static final LocationService instance = LocationService._singleton();

  late LoggerService _loggerService;

  factory LocationService(LoggerService loggerService) {
    instance._loggerService = loggerService;
    instance.requestPermission();

    return instance;
  }

  LocationServiceStatus locationServiceStatus = LocationServiceStatus.disabled;

  LocationPermissionStatus locationPermissionStatus = LocationPermissionStatus.denied;

  final StreamController<PositionModel?> _lastKnownPositionStreamController =
      StreamController<PositionModel?>.broadcast();

  Stream<PositionModel?> get lastKnownPosition => _lastKnownPositionStreamController.stream;

  Future<void> checkPermission() async {
    final permission = await _handlePermission(Geolocator.checkPermission);
    locationPermissionStatus = permission;
  }

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
      _loggerService.logError('Error handling location permission: $error', stackTrace: stackTrace);
      return LocationPermissionStatus.denied;
    }
  }

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
        _loggerService.logError('Error getting current location: $error', stackTrace: stackTrace);
      }
    }

    return null;
  }

  Future<Tuple2<String, String>?> getLocationFromPosition(PositionModel position) async {
    try {
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isEmpty) return null;

      return Tuple2(placemarks.first.subAdministrativeArea ?? '', placemarks.first.country ?? '');
    } catch (error, stackTrace) {
      _loggerService.logError('Error getting city name from location: $error',
          stackTrace: stackTrace);
    }

    return null;
  }
}
