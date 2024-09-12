import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';

part 'network_service.g.dart';

class NetworkService = NetworkServiceBase with _$NetworkService;

enum NetworkStatus { connected, disconnected }

abstract class NetworkServiceBase with Store {
  final Connectivity _connectivity;
  final LoggerServiceImpl _loggerService;

  NetworkServiceBase(this._connectivity, this._loggerService) {
    _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.mobile) ||
            result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.ethernet)) {
          networkStatus = NetworkStatus.disconnected;
          _loggerService.log('Network disconnected');
        } else {
          networkStatus = NetworkStatus.connected;
          _loggerService.log('Network connected');
        }
      },
    );
  }

  @observable
  NetworkStatus networkStatus = NetworkStatus.disconnected;
}
