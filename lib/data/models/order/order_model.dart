

class OrderModel {
  final String id;
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
  // final String? driverId;
  // final int? rating;
  // final String? feedback;
  // final String? promoCode;
  // final double? discountAmount;
  // final String? notes;
  final DateTime orderDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.id,
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
    // this.driverId,
    // this.rating,
    // this.feedback,
    // this.promoCode,
    // this.discountAmount,
    // this.notes,
    required this.orderDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
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
      List<double>.from(json['restaurantCoords'].map((e) => e.toDouble())),
      recipientCoords:
      List<double>.from(json['recipientCoords'].map((e) => e.toDouble())),
      // driverId: json['driverId'],
      // rating: json['rating'],
      // feedback: json['feedback'],
      // promoCode: json['promoCode'],
      // discountAmount: json['discountAmount']?.toDouble(),
      // notes: json['notes'],
      orderDate: DateTime.parse(json['orderDate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
class OrderItem {
  final FoodId foodId;
  final int quantity;
  final double price;
  final List<String> additives;
  final String instructions;
  final String id;

  OrderItem({
    required this.foodId,
    required this.quantity,
    required this.price,
    required this.additives,
    required this.instructions,
    required this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      foodId: FoodId.fromJson(json['foodId']),
      quantity: json['quantity'],
      price: (json['price'] ?? 0).toDouble(),
      additives: List<String>.from(json['additives'].map((x) => x)),
      instructions: json['instructions'] ?? '',
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId.toJson(),
      'quantity': quantity,
      'price': price,
      'additives': List<dynamic>.from(additives.map((x) => x)),
      'instructions': instructions,
      '_id': id,
    };
  }
}

class FoodId {
  final String id;
  final String title;
  final double rating;
  final List<String> imageUrl;
  final String time;

  FoodId({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.time,
  });

  factory FoodId.fromJson(Map<String, dynamic> json) {
    return FoodId(
      id: json['_id'],
      title: json['title'],
      rating: (json['rating'] ?? 0).toDouble(),
      imageUrl: List<String>.from(json['imageUrl'].map((x) => x)),
      time: json['time'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'rating': rating,
      'imageUrl': List<dynamic>.from(imageUrl.map((x) => x)),
      'time': time,
    };
  }
}
