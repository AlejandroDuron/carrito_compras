import 'package:flutter/material.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  //Lista de los 5 productos
  final List<Product> _catalog = [
    Product(
      id: '1',
      name: 'Mochila Urbana Oxford',
      description: 'Resistente al agua, 20L',
      price: 45,
      originalPrice: 52,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAGLMcSblCPLwvE5K3udkSSQ0s871O8m_0zFIyNUesFUGqUKcdTZbqJxAf-Gd-yLO8on8txOGkYa2Ym5Xxf5ZLNgw9TIWh0PoV9mocGFHJsbFjSLtRPl6572CzISQ5MUpzxcxp9qbZTG2YWNqSyDhEAP2c-d3gHbkshsg3KLsqaqXqkt6bVIO4w9Em1CUIP53w_H0AN1hEJKUDrVlOWwUguqq_XKkc5tTWx3mofLw',
    ),
    Product(
      id: '2',
      name: 'Auriculares Inalámbricos Pro',
      description: 'Cancelación activa de ruido',
      price: 65,
      originalPrice: 75,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCE_TTfjjTUWoqy0lYfomAl40-192NKbQPD4bKqoyXX3txteQaiIcV9jmLGlBLjtvvMgMKY3Od7vTD9PhIU-cvNBa1ghLRNpAP1hRzxlBIuEEza-89YJC7PVXaOnbQDNCAeO7s1wFzqYktGUZnTM-1r1HrSykFkF5c8eSDrv8iWusJNAW6ikK6AMwZ-kiqjolDsvXn6s13BRmIKaYvFVVz44o3jatzC_4ttvTLrrA',
    ),
    Product(
      id: '3',
      name: 'Reloj Inteligente Fit Track',
      description: 'Pulsómetro y GPS dual',
      price: 89,
      originalPrice: 99,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCOrm8DN1vweWvyV9J715YhgEnV0GC4hDFvjnDCvsk_OQm9SW3d-cEQ6d6Nt--uYf7dwbSalTiWgpaEYWaTQe9CzKiypsGl-fVlB-2_MCm5umCzV1jaCF47saKB9hFXZpyLvlCCc_pFnkMgE9ybZ_YvbKK8Zdd-5Bw92t0jbyrYmnSFAH3QaVSaa-GDYX-b24Qr2I2-3M_u4smmS9QfvmSwtfRi9l6phEjdRCEh9w',
    ),
    Product(
      id: '4',
      name: 'Termo de Acero Inoxidable',
      description: 'Aislamiento térmico 24h',
      price: 225,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuALxeGcuDL5z81mK5GI6aMDQirsjoJ8cqfXWWIouj4n3n3wp_IfDmkyRhykSy2sWq6A_xNdggMkas8p9xdmgtZVrCIP_F2y-Ry9NgyrjAPm5yQvZ97YW9EyF2BdwgiFdDiSSJqsH8SOvnpgmX5emQFsZ2DuRvKJ8IuVc_wQyKTVRQBHXNVOe8Br0PZMkLx0hl0KPGFTvEjnDS7uz_wfnDOadDUuHPCPIJv1gycw6A',
    ),
    Product(
      id: '5',
      name: 'Lentes de Sol Polarizados',
      description: 'Protección UV400 completa',
      price: 34,
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCnPs4dJxeUm02HSW8hjK7-6WgV7xjQomAqGQsxaeXIUq8X97dgpbS8dXLZOlvhi6t-4ol0zy20DWz1gYBu6h1_LRjpKMbdXGdPdBViqw3wYGkwoXKtOwSgQ9dkuPOGkT0MfGx9s228-oybJQTROS2DcyLN8k0oLCBwZdvwdeMlGGN1ne8YCJ09f6KO6AB0r6SVBkDqcVemzUqzoJgi1a-I-PplFBU89ihIfWxCpw',
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
