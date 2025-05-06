import 'package:myapp/features/catalog/domain/entities/product.dart';

class PackageItem {
  final Product product;
  final double quantity;

  PackageItem({required this.product, required this.quantity});

  Map<String, dynamic> toJson() => {
    'product': product.toJson(),
    'quantity': quantity,
  };

  factory PackageItem.fromJson(Map<String, dynamic> json) => PackageItem(
    product: Product.fromJson(json['product']),
    quantity: json['quantity'],
  );
}
