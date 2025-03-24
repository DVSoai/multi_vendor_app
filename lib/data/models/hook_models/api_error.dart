// import 'dart:convert';
//
// RestaurantModel restaurantModelFromJson(String str) => RestaurantModel.fromJson(json.decode(str));
//
// String restaurantModelToJson(RestaurantModel data) => json.encode(data.toJson());
//
// class RestaurantModel {
//   final bool status;
//   final String message;
//
//   RestaurantModel({
//     required this.status,
//     required this.message,
//   });
//
//   factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
//     status: json["status"],
//     message: json["message"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//   };
// }