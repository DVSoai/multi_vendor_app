class DistanceTime {
  final double distance; // in kilometers
  final double time; // in hours
  final double price; // in currency units

  DistanceTime({
    required this.distance,
    required this.time,
    required this.price,
  });

  @override
  String toString() {
    return 'Distance: $distance km, Time: $time hours, Price: $price';
  }
}