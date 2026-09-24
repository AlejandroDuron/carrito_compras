import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Se importa el provider y la pantalla del catalogo
import 'providers/cart_provider.dart';
import 'screens/catalog_screen.dart';

void main() {
  runApp(
    // la app usa el changenotifierprovider
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrito Provider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5)),
        useMaterial3: true,
      ),
      home: const CatalogScreen(), // go pantalla 1
    );
  }
}
