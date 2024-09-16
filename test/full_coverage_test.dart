// ignore_for_file: unused_import
import 'package:weather_forecast_app/app/app_module.dart';
import 'package:weather_forecast_app/app/app_widget.dart';
import 'package:weather_forecast_app/app/core/components/structure/custom_app_bar.dart';
import 'package:weather_forecast_app/app/core/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:weather_forecast_app/app/core/components/buttons/custom_button.dart';
import 'package:weather_forecast_app/app/core/components/structure/custom_scaffold.dart';
import 'package:weather_forecast_app/app/core/components/structure/temporary_widget.dart';
import 'package:weather_forecast_app/app/core/components/text/custom_text.dart';
import 'package:weather_forecast_app/app/core/components/toasts/toasts.dart';
import 'package:weather_forecast_app/app/core/errors/exceptions.dart';
import 'package:weather_forecast_app/app/core/errors/failures.dart';
import 'package:weather_forecast_app/app/core/models/country/country_model.dart';
import 'package:weather_forecast_app/app/core/models/location/location_model.dart';
import 'package:weather_forecast_app/app/core/models/position/position_model.dart';
import 'package:weather_forecast_app/app/core/models/response/rest_client_response.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/daily_weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_forecast_model.dart';
import 'package:weather_forecast_app/app/core/models/weather_forecast/weather_property_model.dart';
import 'package:weather_forecast_app/app/core/routes/animated_route.dart';
import 'package:weather_forecast_app/app/core/routes/app_routes.dart';
import 'package:weather_forecast_app/app/core/services/countries_service/countries_service.dart';
import 'package:weather_forecast_app/app/core/services/local_storage/local_storage.dart';
import 'package:weather_forecast_app/app/core/services/location_service/location_service.dart';
import 'package:weather_forecast_app/app/core/services/logger/logger_service.dart';
import 'package:weather_forecast_app/app/core/services/network_service/network_service.dart';
import 'package:weather_forecast_app/app/core/services/rest_client/rest_client.dart';
import 'package:weather_forecast_app/app/core/states/general_state.dart';
import 'package:weather_forecast_app/app/core/theme/app_colors.dart';
import 'package:weather_forecast_app/app/core/theme/app_theme.dart';
import 'package:weather_forecast_app/app/core/theme/status_bar_theme.dart';
import 'package:weather_forecast_app/app/core/utils/constants.dart';
import 'package:weather_forecast_app/app/core/utils/date_extension.dart';
import 'package:weather_forecast_app/app/core/utils/env_vars.dart';
import 'package:weather_forecast_app/app/core/utils/parsers.dart';
import 'package:weather_forecast_app/app/core/utils/strings.dart';
import 'package:weather_forecast_app/app/modules/home/home_module.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/favorite_locations_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/datasources/fetch_weather_datasource.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/exceptions.dart';
import 'package:weather_forecast_app/app/modules/home/infra/errors/failures.dart';
import 'package:weather_forecast_app/app/modules/home/infra/repositories/favorite_locations_repository.dart';
import 'package:weather_forecast_app/app/modules/home/infra/repositories/fetch_weather_repository.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/bottom_sheet/favorite_locations_bottom_sheet.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/bottom_sheet/location_bottom_sheet.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/cards/first_card_weather_forecast.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/cards/second_card_weather_forecast.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/cards/third_card_weather_forecast.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/date_widget.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/favorite_widget.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/structure/column_weather_property_widget.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/structure/row_weather_property_widget.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/components/text_field/location_text_field.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/enums/weather_condition.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/home_page.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/select_city_page.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/pages/select_country_page.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/favorite_locations_store.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/location_store.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/favorite_locations_states.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/location_states.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/states/weather_states.dart';
import 'package:weather_forecast_app/app/modules/home/presentation/stores/weather_store.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/pages/splash_page.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/stores/splash_store.dart';
import 'package:weather_forecast_app/app/modules/splash/presentation/stores/states/splash_states.dart';
import 'package:weather_forecast_app/app/modules/splash/spash_module.dart';
import 'package:weather_forecast_app/main.dart';

void main() {}
