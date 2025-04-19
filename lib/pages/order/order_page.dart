import 'package:flutter/material.dart';
import 'package:multi_vendor_app/common/back_ground_container.dart';
import 'package:multi_vendor_app/data/models/hook_models/restaurant_model.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key,  this.restaurant});
  final RestaurantModel? restaurant;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Page'),
        centerTitle: true,
      ),
      body: BackGroundContainer(
        color: Colors.white,
        child: Container(),
      ),
    );
  }
}
