import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';

enum NetworkStatus { connected, disconnected }

abstract class NetworkService {
  NetworkStatus networkStatus = NetworkStatus.disconnected;
  bool get isConnected;
}

class NetworkServiceImpl implements NetworkService {
  NetworkServiceImpl._singleton();
  static final NetworkServiceImpl instance = NetworkServiceImpl._singleton();

  late Connectivity _connectivity;
  late LoggerService _loggerService;

  factory NetworkServiceImpl(Connectivity connectivity, LoggerService loggerService) {
    instance._connectivity = connectivity;
    instance._loggerService = loggerService;
    instance._init();

    return instance;
  }

  @override
  NetworkStatus networkStatus = NetworkStatus.disconnected;

  @override
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
