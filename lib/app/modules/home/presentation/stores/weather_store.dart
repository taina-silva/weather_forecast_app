import 'package:mobx/mobx.dart';
import 'package:weather_forecast_app/app/core/errors/failures.dart';
import 'package:weather_forecast_app/app/modules/home/infra/repositories/fetch_weather_repository.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/weather_states.dart';

part 'weather_store.g.dart';

class WeatherStore = WeatherStoreBase with _$WeatherStore;

abstract class WeatherStoreBase with Store {
  final FetchWeatherRepository _repository;

  WeatherStoreBase(this._repository);

  @observable
  GetWeatherState state = GetWeatherInitialState();

  @action
  Future<void> fetchWeather(String city) async {
    state = GetWeatherLoadingState();

    final result = await _repository.fetchWeather(city);

    result.fold(
      (failure) {
        if (failure is NoConnectionFailure) {
          state = GetWeatherNoConnectionState();
        } else {
          state = GetWeatherErrorState(failure.message);
        }
      },
      (list) => state = GetWeatherSuccessState(list),
    );
  }
}
