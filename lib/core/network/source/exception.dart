// Custom Exception Classes
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic errorResponse;

  NetworkException({
    required this.message,
    this.statusCode,
    this.errorResponse
  });

  @override
  String toString() {
    return 'NetworkException: $message (Status Code: $statusCode)';
  }
}