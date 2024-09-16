import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';

enum NetworkStatus { connected, disconnected }

class NetworkService {
  NetworkService._singleton();
  static final NetworkService instance = NetworkService._singleton();

  late Connectivity _connectivity;
  late LoggerService _loggerService;

  factory NetworkService(Connectivity connectivity, LoggerService loggerService) {
    instance._connectivity = connectivity;
    instance._loggerService = loggerService;
    instance._init();

    return instance;
  }

  NetworkStatus networkStatus = NetworkStatus.disconnected;

  bool get isConnected => networkStatus == NetworkStatus.connected;

  void _init() {
    _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.mobile) ||
            result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.ethernet)) {
          networkStatus = NetworkStatus.connected;
          _loggerService.log('Network connected');
        } else {
          networkStatus = NetworkStatus.disconnected;
          _loggerService.log('Network disconnected');
        }
      },
    );
  }
}
