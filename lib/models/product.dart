class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
  });
}
