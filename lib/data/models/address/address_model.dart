class AddressModel {
  final String addressLine1;
  final String postalCode;
  final bool addressModelDefault;
  final String deliveryInstructions;
  final double latitude;
  final double longitude;

  AddressModel({
    required this.addressLine1,
    required this.postalCode,
    required this.addressModelDefault,
    required this.deliveryInstructions,
    required this.latitude,
    required this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressLine1: json['addressLine1'] ?? '',
      postalCode: json['postalCode'] ?? '',
      addressModelDefault: json['default'] ?? false,
      deliveryInstructions: json['deliveryInstructions'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'postalCode': postalCode,
      'default': addressModelDefault,
      'deliveryInstructions': deliveryInstructions,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
