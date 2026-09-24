import 'package:flutter/material.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  //Lista de los 5 productos
  final List<Product> _catalog = [
    Product(
      id: '1',
      name: 'Mochila Urbana Oxford',
      description: 'Resistente al agua, 20L',
      price: 45000,
      originalPrice: 52000,
    ),
    Product(
      id: '2',
      name: 'Auriculares Inalámbricos Pro',
      description: 'Cancelación activa de ruido',
      price: 65000,
      originalPrice: 75000,
    ),
    Product(
      id: '3',
      name: 'Reloj Inteligente Fit Track',
      description: 'Pulsómetro y GPS dual',
      price: 89000,
      originalPrice: 99000,
    ),
    Product(
      id: '4',
      name: 'Termo de Acero Inoxidable',
      description: 'Aislamiento térmico 24h',
      price: 22500,
    ),
    Product(
      id: '5',
      name: 'Lentes de Sol Polarizados',
      description: 'Protección UV400 completa',
      price: 34000,
    ),
  ];

  final List<Product> _selectedProducts = [];

  // Get para exponer estado
  List<Product> get catalog => _catalog;
  List<Product> get selectedProducts => _selectedProducts;
  int get selectedCount => _selectedProducts.length;

  // Habilitar/deshabilitar el botón de proceder
  bool get canProceed => _selectedProducts.length == 3;

  //Calculo de total de productos que se han seleccionado
  double get total =>
      _selectedProducts.fold(0, (sum, item) => sum + item.price);

  //select o no selected
  void toggleSelection(Product product) {
    if (_selectedProducts.contains(product)) {
      _selectedProducts.remove(product);
    } else {
      if (_selectedProducts.length < 3) {
        _selectedProducts.add(product);
      }
    }
    //se notifica el cambio de estado a los widgets que escuchan este provider
    notifyListeners();
  }
}
