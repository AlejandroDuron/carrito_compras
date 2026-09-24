//este codigo lo puse para probar el flujo, las personas encargadas de ui (creo que la 2) hacen esto
import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumen de compra')),
      body: const Center(
        child: Text('Pantalla 2 en construcción por Persona 2'),
      ),
    );
  }
}
