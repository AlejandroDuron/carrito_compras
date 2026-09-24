//este codigo lo puse para probar el flujo, las personas encargadas de ui (creo que la 2) hacen esto
import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo')),
      body: const Center(
        child: Text('Pantalla 1 en construcción por Persona 2'),
      ),
    );
  }
}
