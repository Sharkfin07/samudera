import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/config/env_config.dart';

class ApiClient {
  ApiClient._internal()
    : _dio = Dio(
        BaseOptions(
          baseUrl: EnvConfig.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 20),
          sendTimeout: const Duration(seconds: 20),
          headers: {'Accept': 'application/json'},
        ),
      ) {
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
      ),
      if (kDebugMode) LogInterceptor(responseBody: true, requestBody: true),
    ]);
  }

  factory ApiClient.instance() => _singleton;
  static final ApiClient _singleton = ApiClient._internal();

  final Dio _dio;
  final String apiKey = EnvConfig.apiKey;

  Dio get rawDio => _dio;

  // Generic method for all Alphavantage API calls
  Future<Response<T>> query<T>({
    required String function,
    Map<String, String>? parameters,
  }) {
    final Map<String, String> queryParams = {
      'function': function,
      'apikey': apiKey,
      if (parameters != null) ...parameters,
    };

    return _dio.get<T>('/query', queryParameters: queryParams);
  }
}
