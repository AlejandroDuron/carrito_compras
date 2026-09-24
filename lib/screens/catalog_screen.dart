import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'summary_screen.dart';

// Colores del diseño de Stitch (paleta slate/blue de Tailwind)
const _brand = Color(0xFF1E88E5);
const _blue50 = Color(0xFFEFF6FF);
const _blue100 = Color(0xFFDBEAFE);
const _blue200 = Color(0xFFBFDBFE);
const _blue400 = Color(0xFF60A5FA);
const _slate50 = Color(0xFFF8FAFC);
const _slate100 = Color(0xFFF1F5F9);
const _slate200 = Color(0xFFE2E8F0);
const _slate300 = Color(0xFFCBD5E1);
const _slate400 = Color(0xFF94A3B8);
const _slate500 = Color(0xFF64748B);
const _slate600 = Color(0xFF475569);
const _slate700 = Color(0xFF334155);
const _slate800 = Color(0xFF1E293B);
const _slate900 = Color(0xFF0F172A);

const _requiredCount = 3;

// Formatea 45000 -> $45.000
String formatPrice(double value) {
  final digits = value.round().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  return '\$$buffer';
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: _slate50,
      body: Stack(
        children: [
          // Degradado azul superior
          Container(
            height: 288,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _blue200.withValues(alpha: 0.6),
                  _blue50.withValues(alpha: 0.4),
                  _slate50.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _Header(badgeCount: cart.selectedCount),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    children: [
                      _ProgressBanner(selected: cart.selectedCount),
                      const SizedBox(height: 16),
                      for (final product in cart.catalog) ...[
                        _ProductCard(
                          product: product,
                          selected: cart.selectedProducts.contains(product),
                          // Si ya hay 3 seleccionados, los demás se atenúan
                          disabled: cart.canProceed &&
                              !cart.selectedProducts.contains(product),
                          onTap: () => context
                              .read<CartProvider>()
                              .toggleSelection(product),
                        ),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 8),
                      const _IncentiveBanner(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomBar(
        enabled: cart.canProceed,
        onContinue: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SummaryScreen()),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int badgeCount;

  const _Header({required this.badgeCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        border: Border(bottom: BorderSide(color: _blue50.withValues(alpha: 0.6))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu_rounded, color: _slate700),
            tooltip: 'Menú principal',
          ),
          const Text(
            'Catálogo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _slate900,
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: _slate700,
                ),
                tooltip: 'Carrito de compras',
              ),
              if (badgeCount > 0)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _brand,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Text(
                      '$badgeCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressBanner extends StatelessWidget {
  final int selected;

  const _ProgressBanner({required this.selected});

  @override
  Widget build(BuildContext context) {
    final missing = _requiredCount - selected;
    final complete = missing == 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _blue100),
        boxShadow: [
          BoxShadow(
            color: _slate900.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: _blue50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notes_rounded, size: 16, color: _brand),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$selected de $_requiredCount productos seleccionados',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _slate800,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _blue50,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _blue100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: _brand,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      complete ? 'Completo' : 'Falta $missing',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _brand,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 1),
                child: Icon(Icons.info, size: 14, color: _blue400),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  complete
                      ? '¡Listo! Tu orden combinada está desbloqueada.'
                      : missing == 1
                          ? 'Selecciona un artículo más para desbloquear la orden combinada.'
                          : 'Selecciona $missing artículos más para desbloquear la orden combinada.',
                  style: const TextStyle(fontSize: 12, color: _slate500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;

  const _ProductCard({
    required this.product,
    required this.selected,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: disabled ? 0.5 : 1,
      child: GestureDetector(
        onTap: disabled ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: selected ? _brand : _slate100,
              width: selected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: selected
                    ? _brand.withValues(alpha: 0.08)
                    : _slate900.withValues(alpha: 0.03),
                blurRadius: selected ? 16 : 12,
                offset: Offset(0, selected ? 6 : 3),
              ),
            ],
          ),
          child: Row(
            children: [
              _Thumbnail(url: product.imageUrl),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _slate900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: _slate500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatPrice(product.price),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: _slate900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              _CheckCircle(selected: selected),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final String? url;

  const _Thumbnail({this.url});

  @override
  Widget build(BuildContext context) {
    const placeholder = Icon(Icons.image_outlined, color: _slate400);

    return Container(
      width: 64,
      height: 64,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _slate100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _slate100),
      ),
      child: url == null
          ? placeholder
          : Image.network(
              url!,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => placeholder,
            ),
    );
  }
}

class _CheckCircle extends StatelessWidget {
  final bool selected;

  const _CheckCircle({required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? _brand : Colors.white,
        border: selected ? null : Border.all(color: _slate300, width: 2),
      ),
      child: selected
          ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
          : null,
    );
  }
}

class _IncentiveBanner extends StatelessWidget {
  const _IncentiveBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _blue50.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _blue100.withValues(alpha: 0.8)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Icon(Icons.verified_user_outlined, size: 16, color: _brand),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'La selección de 3 artículos desbloquea automáticamente el paquete '
              'con envío express sin costo y garantía directa de fábrica.',
              style: TextStyle(fontSize: 12, color: _slate600, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final bool enabled;
  final VoidCallback onContinue;

  const _BottomBar({required this.enabled, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        border: const Border(top: BorderSide(color: _slate100)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: enabled ? onContinue : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: _brand,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: _slate200,
                    disabledForegroundColor: _slate400,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Continuar'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    enabled ? Icons.lock_open_rounded : Icons.lock_outline_rounded,
                    size: 14,
                    color: enabled ? _brand : _slate400,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    enabled
                        ? 'Orden lista para continuar'
                        : 'Selecciona 3 productos para continuar',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: enabled ? _brand : _slate400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
