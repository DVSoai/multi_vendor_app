

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:multi_vendor_app/core/network/local/global_storage.dart';


import 'api_type.dart';
import 'error_handler.dart';
import 'exception.dart';

class ApiClient {
  final Dio _dio;
  final GlobalStorage _globalStorage;

  ApiClient(this._dio, this._globalStorage) {
    _dio.options = BaseOptions(
      baseUrl:
      'http://192.168.1.30:6013',
      // 'http://192.168.2.31:6013', // Set your base URL
      connectTimeout: const Duration(seconds: 10), // Timeout for connecting
      receiveTimeout: const Duration(seconds: 10), // Timeout for receiving data
    );
    // Configure Dio interceptors
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      final token = _globalStorage.userToken;
      options.headers['Content-Type'] = 'application/json; charset=UTF-8';
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      // if (kDebugMode) {
      debugPrint('Request: ${options.method} ${options.path}');
      debugPrint('Request Headers: ${options.headers}');
      debugPrint('Request Data: ${options.data}');
      // }

      return handler.next(options);
    }, onResponse: (response, handler) {
      if (kDebugMode) {
        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Data: ${response.data}');
      }

      return handler.next(response);
    }, onError: (DioException error, handler) {
      if (kDebugMode) {
        debugPrint("Error intercepted: ${error.response?.statusCode}");
        debugPrint("Error response: ${error.response?.data}");
      }
      handler.next(error);
    }));
  }

  Future<dynamic> request({
    required String path,
    required ApiType method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
    bool requiresAuth = true,
  }) async {
    try {
      Response response;
      // print('inside request');

      switch (method) {
        case ApiType.get:
          response = await _dio.get(path,
              queryParameters: queryParameters,
              // options: Options(headers: headers)
          );
          break;
        case ApiType.post:
          response = await _dio.post(path,
              data: data,

              queryParameters: queryParameters,

              // options: Options(headers: headers)
          );
          break;
        case ApiType.put:
          response = await _dio.put(path,
              data: data,
              queryParameters: queryParameters,
              // options: Options(headers: headers)
          );
          break;
        case ApiType.delete:
          response = await _dio.delete(path,
              data: data,
              queryParameters: queryParameters,
              // options: Options(headers: headers)
          );
          break;
        case ApiType.patch:
          response = await _dio.patch(path,
              data: data,
              queryParameters: queryParameters,
              // options: Options(headers: headers)
          );
          break;
      }

      return response.data;
    } on DioException catch (e) {
      debugPrint("error in request $e");
      throw ErrorHandler.transformError(e);
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }
}
