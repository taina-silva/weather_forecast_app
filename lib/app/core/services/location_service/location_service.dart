import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/services/location_service/models/location_model.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';

part 'location_service.g.dart';

class LocationService = LocationServiceBase with _$LocationService;

enum LocationServiceStatus { enabled, disabled }

enum LocationPermissionStatus { ask, granted, denied }

abstract class LocationServiceBase with Store {
  final LoggerService _loggerService;

  List<ReactionDisposer> reactions = [];

  LocationServiceBase(this._loggerService) {
    Geolocator.getServiceStatusStream().listen((status) {
      if (status == ServiceStatus.disabled) {
        locationServiceStatus = LocationServiceStatus.disabled;
      } else {
        locationServiceStatus = LocationServiceStatus.enabled;
      }
    });

    reactions = [
      reaction((_) => locationServiceStatus, (LocationServiceStatus status) {
        if (status == LocationServiceStatus.disabled) {
          locationPermissionStatus = LocationPermissionStatus.denied;
        } else {
          checkPermission();
        }
      }),
      reaction((_) => locationPermissionStatus, (LocationPermissionStatus status) {
        if (status == LocationPermissionStatus.ask) requestPermission();
      }),
    ];
  }

  @observable
  LocationServiceStatus locationServiceStatus = LocationServiceStatus.disabled;

  @observable
  LocationPermissionStatus locationPermissionStatus = LocationPermissionStatus.denied;

  @action
  Future<void> checkPermission() async {
    try {
      final result = await Geolocator.checkPermission();
      if (result == LocationPermission.always || result == LocationPermission.whileInUse) {
        locationPermissionStatus = LocationPermissionStatus.granted;
      } else if (result == LocationPermission.denied) {
        locationPermissionStatus = LocationPermissionStatus.ask;
      } else {
        locationPermissionStatus = LocationPermissionStatus.denied;
      }
    } catch (error, stackTrace) {
      _loggerService.logError('Error checking location permission: $error', stackTrace: stackTrace);
      locationPermissionStatus = LocationPermissionStatus.denied;
    }
  }

  @action
  Future<void> requestPermission() async {
    try {
      final result = await Geolocator.requestPermission();

      if (result == LocationPermission.always || result == LocationPermission.whileInUse) {
        locationPermissionStatus = LocationPermissionStatus.granted;
      } else {
        locationPermissionStatus = LocationPermissionStatus.denied;
      }
    } catch (error, stackTrace) {
      _loggerService.logError('Error requesting location permission: $error',
          stackTrace: stackTrace);
      locationPermissionStatus = LocationPermissionStatus.denied;
    }
  }

  Future<LocationModel?> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      return LocationModel(latitude: position.latitude, longitude: position.longitude);
    } catch (error, stackTrace) {
      _loggerService.logError('Error getting current location: $error', stackTrace: stackTrace);
    }

    return null;
  }
}
