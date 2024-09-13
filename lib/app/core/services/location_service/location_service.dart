import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_forecast_app/app/core/services/location_service/models/location_model.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';

part 'location_service.g.dart';

enum LocationServiceStatus { enabled, disabled }

enum LocationPermissionStatus { granted, denied }

class LocationService = LocationServiceBase with _$LocationService;

abstract class LocationServiceBase with Store {
  final LoggerService _loggerService;

  LocationServiceBase(this._loggerService) {
    getCurrentLocation();
  }

  @observable
  LocationServiceStatus locationServiceStatus = LocationServiceStatus.disabled;

  @observable
  LocationPermissionStatus locationPermissionStatus = LocationPermissionStatus.denied;

  @observable
  LocationModel? lastKnownLocation;

  @action
  Future<void> checkPermission() async {
    final permission = await _handlePermission(Geolocator.checkPermission);
    locationPermissionStatus = permission;
  }

  @action
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

  @action
  Future<LocationModel?> getCurrentLocation({bool forceFetch = false}) async {
    if (lastKnownLocation != null && !forceFetch) return lastKnownLocation;

    try {
      final position = await Geolocator.getCurrentPosition();
      final location = LocationModel(latitude: position.latitude, longitude: position.longitude);
      lastKnownLocation = location;
      return location;
    } catch (error, stackTrace) {
      if (error is PermissionDeniedException) {
        requestPermission();
      } else {
        _loggerService.logError('Error getting current location: $error', stackTrace: stackTrace);
      }
    }

    return null;
  }

  @action
  Future<Tuple2<String, String>?> getCityNameFromLocation({LocationModel? location}) async {
    final loc = location ?? lastKnownLocation ?? await getCurrentLocation();
    if (loc == null) return null;

    try {
      final placemarks = await placemarkFromCoordinates(loc.latitude, loc.longitude);
      if (placemarks.isEmpty) return null;

      return Tuple2(placemarks.first.subAdministrativeArea ?? '', placemarks.first.country ?? '');
    } catch (error, stackTrace) {
      _loggerService.logError('Error getting city name from location: $error',
          stackTrace: stackTrace);
    }

    return null;
  }
}
