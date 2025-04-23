class OrderRequestModel {
  final String userId;
  final List<OrderItem> orderItems;
  final double orderTotal;
  final double deliveryFee;
  final double grandTotal;
  final String deliveryAddress;
  final String restaurantAddress;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final String restaurantId;
  final List<double> restaurantCoords;
  final List<double> recipientCoords;
  final String driverId;
  final int rating;
  final String feedback;
  final String promoCode;
  final double discountAmount;
  final String notes;

  OrderRequestModel({
    required this.userId,
    required this.orderItems,
    required this.orderTotal,
    required this.deliveryFee,
    required this.grandTotal,
    required this.deliveryAddress,
    required this.restaurantAddress,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.restaurantId,
    required this.restaurantCoords,
    required this.recipientCoords,
    required this.driverId,
    required this.rating,
    required this.feedback,
    required this.promoCode,
    required this.discountAmount,
    required this.notes,
  });

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderRequestModel(
      userId: json['userId'],
      orderItems: List<OrderItem>.from(
          json['orderItems'].map((x) => OrderItem.fromJson(x))),
      orderTotal: (json['orderTotal'] ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0).toDouble(),
      grandTotal: (json['grandTotal'] ?? 0).toDouble(),
      deliveryAddress: json['deliveryAddress'],
      restaurantAddress: json['restaurantAddress'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      orderStatus: json['orderStatus'],
      restaurantId: json['restaurantId'],
      restaurantCoords:
          List<double>.from(json['restaurantCoords'].map((x) => x.toDouble())),
      recipientCoords:
          List<double>.from(json['recipientCoords'].map((x) => x.toDouble())),
      driverId: json['driverId'],
      rating: json['rating'],
      feedback: json['feedback'],
      promoCode: json['promoCode'],
      discountAmount: (json['discountAmount'] ?? 0).toDouble(),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orderItems': List<dynamic>.from(orderItems.map((x) => x.toJson())),
      'orderTotal': orderTotal,
      'deliveryFee': deliveryFee,
      'grandTotal': grandTotal,
      'deliveryAddress': deliveryAddress,
      'restaurantAddress': restaurantAddress,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'orderStatus': orderStatus,
      'restaurantId': restaurantId,
      'restaurantCoords': List<dynamic>.from(restaurantCoords.map((x) => x)),
      'recipientCoords': List<dynamic>.from(recipientCoords.map((x) => x)),
      'driverId': driverId,
    };
  }

  OrderRequestModel copyWith({
    String? userId,
    List<OrderItem>? orderItems,
    double? orderTotal,
    double? deliveryFee,
    double? grandTotal,
    String? deliveryAddress,
    String? restaurantAddress,
    String? paymentMethod,
    String? paymentStatus,
    String? orderStatus,
    String? restaurantId,
    List<double>? restaurantCoords,
    List<double>? recipientCoords,
    String? driverId,
    int? rating,
    String? feedback,
    String? promoCode,
    double? discountAmount,
    String? notes,
  }) {
    return OrderRequestModel(
      userId: userId ?? this.userId,
      orderItems: orderItems ?? this.orderItems,
      orderTotal: orderTotal ?? this.orderTotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      grandTotal: grandTotal ?? this.grandTotal,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      restaurantAddress: restaurantAddress ?? this.restaurantAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantCoords: restaurantCoords ?? this.restaurantCoords,
      recipientCoords: recipientCoords ?? this.recipientCoords,
      driverId: driverId ?? this.driverId,
      rating: rating ?? this.rating,
      feedback: feedback ?? this.feedback,
      promoCode: promoCode ?? this.promoCode,
      discountAmount: discountAmount ?? this.discountAmount,
      notes: notes ?? this.notes,
    );
  }
}

class OrderItem {
  final String foodId;
  final int quantity;
  final double price;
  final List<String> additives;
  final String instructions;

  OrderItem({
    required this.foodId,
    required this.quantity,
    required this.price,
    required this.additives,
    required this.instructions,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      foodId: json['foodId'],
      quantity: json['quantity'],
      price: (json['price'] ?? 0).toDouble(),
      additives: List<String>.from(json['additives'].map((x) => x)),
      instructions: json['instructions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'quantity': quantity,
      'price': price,
      'additives': List<dynamic>.from(additives.map((x) => x)),
      'instructions': instructions,
    };
  }

  OrderItem copyWith({
    String? foodId,
    int? quantity,
    double? price,
    List<String>? additives,
    String? instructions,
  }) {
    return OrderItem(
      foodId: foodId ?? this.foodId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      additives: additives ?? this.additives,
      instructions: instructions ?? this.instructions,
    );
  }
}
