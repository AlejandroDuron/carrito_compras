// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:carrito_compras/main.dart';
import 'package:carrito_compras/providers/cart_provider.dart';

void main() {
  testWidgets('completa el flujo de selección y pago', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('0 de 3 productos seleccionados'), findsOneWidget);
    expect(find.text('Resumen de compra'), findsNothing);

    for (final productName in [
      'Mochila Urbana Oxford',
      'Auriculares Inalámbricos Pro',
      'Reloj Inteligente Fit Track',
    ]) {
      await tester.tap(find.text(productName));
      await tester.pump();
    }

    expect(find.text('3 de 3 productos seleccionados'), findsOneWidget);
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    expect(find.text('Resumen de compra'), findsOneWidget);
    expect(find.text('Total:'), findsOneWidget);
    expect(find.text('\$199.00'), findsOneWidget);

    await tester.tap(find.text('Proceder a pagar'));
    await tester.pumpAndSettle();

    expect(find.text('Compra realizada'), findsOneWidget);
    expect(
      find.text('¡Compra confirmada!\nTotal pagado: \$199.00'),
      findsOneWidget,
    );
  });
}
