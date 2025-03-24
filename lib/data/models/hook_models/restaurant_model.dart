
import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) => RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) => json.encode(data.toJson());

class RestaurantModel {
  final Coords coords;
  final String id;
  final String title;
  final String time;
  final String imageUrl;
  final List<dynamic> foods;
  final bool pickup;
  final bool delivery;
  final bool isAvailable;
  final String owner;
  final String code;
  final String logoUrl;
  final int rating;
  final String ratingCount;
  final String verification;
  final String verificationMessage;

  RestaurantModel({
    required this.coords,
    required this.id,
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.foods,
    required this.pickup,
    required this.delivery,
    required this.isAvailable,
    required this.owner,
    required this.code,
    required this.logoUrl,
    required this.rating,
    required this.ratingCount,
    required this.verification,
    required this.verificationMessage,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
    coords: Coords.fromJson(json["coords"]),
    id: json["_id"],
    title: json["title"],
    time: json["time"],
    imageUrl: json["imageUrl"],
    foods: List<dynamic>.from(json["foods"].map((x) => x)),
    pickup: json["pickup"],
    delivery: json["delivery"],
    isAvailable: json["isAvailable"],
    owner: json["owner"],
    code: json["code"],
    logoUrl: json["logoUrl"],
    rating: json["rating"],
    ratingCount: json["ratingCount"],
    verification: json["verification"],
    verificationMessage: json["verificationMessage"],
  );

  Map<String, dynamic> toJson() => {
    "coords": coords.toJson(),
    "_id": id,
    "title": title,
    "time": time,
    "imageUrl": imageUrl,
    "foods": List<dynamic>.from(foods.map((x) => x)),
    "pickup": pickup,
    "delivery": delivery,
    "isAvailable": isAvailable,
    "owner": owner,
    "code": code,
    "logoUrl": logoUrl,
    "rating": rating,
    "ratingCount": ratingCount,
    "verification": verification,
    "verificationMessage": verificationMessage,
  };
}

class Coords {
  final String id;
  final double latitude;
  final double longitude;
  final double latitudeDelta;
  final double longitudeDelta;
  final String address;
  final String title;

  Coords({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.latitudeDelta,
    required this.longitudeDelta,
    required this.address,
    required this.title,
  });

  factory Coords.fromJson(Map<String, dynamic> json) => Coords(
    id: json["id"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    latitudeDelta: json["latitudeDelta"]?.toDouble(),
    longitudeDelta: json["longitudeDelta"]?.toDouble(),
    address: json["address"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "latitude": latitude,
    "longitude": longitude,
    "latitudeDelta": latitudeDelta,
    "longitudeDelta": longitudeDelta,
    "address": address,
    "title": title,
  };
}
