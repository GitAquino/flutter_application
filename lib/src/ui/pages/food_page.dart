// lib/src/ui/pages/food_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/food_controller.dart';
import '../../models/food_category_model.dart';
import '../../models/food_item_model.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late final FoodController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FoodController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Alimentos'),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    _buildSectionTitle('1. Selecione uma Categoria'),
                    _buildCategoryDropdown(),
                    const SizedBox(height: 24),
                    if (_controller.selectedCategory != null) ...[
                      _buildSectionTitle('2. Selecione o Alimento'),
                      _buildFoodItemDropdown(),
                      const SizedBox(height: 24),
                    ],
                    if (_controller.selectedFoodItem != null) ...[
                      _buildSectionTitle('3. Informe o Peso (cru) em gramas'),
                      _buildWeightInput(),
                      const SizedBox(height: 32),
                      _buildResultDisplay(),
                    ],
                  ],
                ),
              ),
              if (_controller.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<FoodCategory>(
      value: _controller.selectedCategory,
      hint: const Text('Categorias...'),
      isExpanded: true,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      items: _controller.categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category.name),
        );
      }).toList(),
      onChanged: _controller.onCategorySelected,
    );
  }

  Widget _buildFoodItemDropdown() {
    if (_controller.foodItems.isEmpty && !_controller.isLoading) {
      return const Text('Nenhum alimento encontrado para esta categoria.');
    }
    return DropdownButtonFormField<FoodItem>(
      value: _controller.selectedFoodItem,
      hint: const Text('Alimentos...'),
      isExpanded: true,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      items: _controller.foodItems.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item.name),
        );
      }).toList(),
      onChanged: _controller.onFoodItemSelected,
    );
  }

  Widget _buildWeightInput() {
    return TextField(
      controller: _controller.weightController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        labelText: 'Peso do alimento cru (g)',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calculate),
          onPressed: _controller.calculateWeight,
        ),
      ),
      onSubmitted: (_) => _controller.calculateWeight(),
    );
  }

  Widget _buildResultDisplay() {
    if (_controller.calculatedWeight == null) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        Text(
          'Peso corrigido (pronto):',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          '${_controller.calculatedWeight!.toStringAsFixed(2)} g',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Fator de correção aplicado: ${_controller.selectedFoodItem!.correctionFactor}',
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
