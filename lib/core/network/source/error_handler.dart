// Centralized error transformation method
import 'package:dio/dio.dart';
import'package:multi_vendor_app/core/network/source/exception.dart';

class ErrorHandler {
  static NetworkException transformError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException(
            message:
            'Connection timeout. Please check your internet connection.',
            statusCode: error.response?.statusCode);

      case DioExceptionType.receiveTimeout:
        return NetworkException(
            message: 'Receive timeout. Server may be experiencing issues.',
            statusCode: error.response?.statusCode);

      case DioExceptionType.sendTimeout:
        return NetworkException(
            message: 'Send timeout. Please try again.',
            statusCode: error.response?.statusCode);

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return NetworkException(
            message: 'Request was cancelled',
            statusCode: error.response?.statusCode);

      case DioExceptionType.connectionError:
        return NetworkException(
            message: 'No internet connection. Please check your network.',
            statusCode: error.response?.statusCode);

      case DioExceptionType.unknown:
      default:
        return NetworkException(
            message: error.message ?? 'An unexpected error occurred',
            statusCode: error.response?.statusCode,
            errorResponse: error.response?.data);
    }
  }

  // Detailed handling of bad responses
  static NetworkException _handleBadResponse(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;

    switch (statusCode) {
      case 400:
        return NetworkException(
            message: '${response?.data['message']}',
            statusCode: statusCode,
            errorResponse: response?.data);

      case 401:
        return NetworkException(
            message: 'Unauthorized. Please log in again.',
            statusCode: statusCode,
            errorResponse: response?.data);

      case 403:
        return NetworkException(
            message: 'Access forbidden. You don\'t have permission.',
            statusCode: statusCode,
            errorResponse: response?.data);

      case 404:
        return NetworkException(
            message: 'Resource not found.',
            statusCode: statusCode,
            errorResponse: response?.data);

      case 500:
        return NetworkException(
            message: 'Internal server error. Please try again later.',
            statusCode: statusCode,
            errorResponse: response?.data);

      default:
        return NetworkException(
            message: 'Unexpected server response',
            statusCode: statusCode,
            errorResponse: response?.data);
    }
  }
}
