import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumen de compra')),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          final selectedProducts = cart.selectedProducts;
          final total = cart.total;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: selectedProducts.length,
                  itemBuilder: (context, index) {
                    final product = selectedProducts[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child:
                              (product.imageUrl == null ||
                                  product.imageUrl!.isEmpty)
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Image.network(
                                  product.imageUrl!,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                ),
                        ),
                        title: Text(product.name),
                        subtitle: Text(
                          product.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: const Text('Compra realizada'),
                            content: Text(
                              '¡Compra confirmada!\n'
                              'Total pagado: '
                              '\$${total.toStringAsFixed(2)}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(dialogContext).pop(),
                                child: const Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Proceder a pagar'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
