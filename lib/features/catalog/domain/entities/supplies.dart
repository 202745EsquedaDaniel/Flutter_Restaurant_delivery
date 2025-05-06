import 'package:myapp/features/catalog/domain/entities/product.dart';

class Supply {
  final Product product;
  final double quantity;

  Supply({required this.product, required this.quantity});

  Map<String, dynamic> toJson() => {
    'product': product.toJson(),
    'quantity': quantity,
  };

  factory Supply.fromJson(Map<String, dynamic> json) => Supply(
    product: Product.fromJson(json['product']),
    quantity: json['quantity'],
  );
}
