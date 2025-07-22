// lib/modules/profile/presenter/profile_page.dart

import 'package:flutter/material.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Lista de alimentos',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
