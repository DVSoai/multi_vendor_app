import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categories'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: const Center(
        child:  Text('Category Page'),
      ),
    );

  }
}
