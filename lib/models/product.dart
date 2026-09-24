class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    this.imageUrl,
  });
}
