// lib/app/pages/placeholder_page.dart

import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Página de $title', style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
