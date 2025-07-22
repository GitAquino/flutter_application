// lib/modules/orders/presenter/orders_page.dart

import 'package:flutter/material.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NathApp'),
      ),
      body: const Center(
        child: Text(
          'Carrinho de compras',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
