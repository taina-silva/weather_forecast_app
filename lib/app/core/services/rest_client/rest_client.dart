import 'package:dio/dio.dart';
import 'package:weather_forecast_app/app/core/services/rest_client/models/rest_client_response.dart';
import 'package:weather_forecast_app/app/core/utils/env_vars.dart';

abstract class RestClient {
  Future<RestClientResponse> get(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<RestClientResponse> post(
    String path, {
    String? baseUrl,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
}

class RestClientImpl implements RestClient {
  RestClientImpl._singleton();
  static final RestClientImpl instance = RestClientImpl._singleton();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: EnvVars.weatherApiUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  static final defaultOptions = Options(
    headers: {'Content-Type': 'application/json'},
    responseType: ResponseType.json,
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  @override
  Future<RestClientResponse> get(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      dio.options.baseUrl = baseUrl ?? EnvVars.weatherApiUrl;

      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options ?? defaultOptions,
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        stackTrace: null,
      );
    } on DioException catch (error, stackTrace) {
      return RestClientResponse(
        data: error.response?.data,
        statusCode: error.response?.statusCode,
        statusMessage: error.response?.statusMessage,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<RestClientResponse> post(
    String path, {
    String? baseUrl,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      dio.options.baseUrl = baseUrl ?? EnvVars.weatherApiUrl;

      final response = await dio.post(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options ?? defaultOptions,
      );

      return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        stackTrace: null,
      );
    } on DioException catch (error, stackTrace) {
      return RestClientResponse(
        data: error.response?.data,
        statusCode: error.response?.statusCode,
        statusMessage: error.response?.statusMessage,
        stackTrace: stackTrace,
      );
    }
  }
}
