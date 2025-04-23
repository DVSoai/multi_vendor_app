class OrderResponse {
  final bool status;
  final String message;
  final String orderId;
  OrderResponse({
    required this.status,
    required this.message,
    required this.orderId,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      orderId: json['orderId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'orderId': orderId,
    };
  }
}