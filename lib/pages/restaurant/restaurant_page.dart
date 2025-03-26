import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor_app/data/models/hook_models/restaurant_model.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key,  this.restaurantModel});

  final RestaurantModel? restaurantModel;

  @override
  Widget build(BuildContext context) {
    print(restaurantModel!.pickup);
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantModel!.title),
        centerTitle: true,
      ),
    );
  }
}
