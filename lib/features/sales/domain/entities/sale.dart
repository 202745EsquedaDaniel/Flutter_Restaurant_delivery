import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/catalog/domain/entities/product.dart';

class Sale {
  final String id;
  final String orgId;
  final String clientId;
  final String type;
  final List<Product> products;
  final double total;
  final double totalPaid;
  final DateTime timestamp;

  Sale({
    required this.id,
    required this.orgId,
    required this.type,
    required this.products,
    required this.clientId,
    required this.total,
    required this.totalPaid,
    required this.timestamp,
  });

  Sale copyWith() {
    return Sale(
      id: id,
      orgId: orgId,
      clientId: clientId,
      type: type,
      products: products,
      total: total,
      totalPaid: totalPaid,
      timestamp: timestamp,
    );
  }

  // convert sale -> json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'clientId': clientId,
      'type': type,
      'products': products.map((product) => product.toJson()).toList(),
      'total': total,
      'totalPaid': totalPaid,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // conver json -> sale
  factory Sale.fromJson(Map<String, dynamic> json) {
    final List<Product> products =
        (json['products'] as List<dynamic>?)
            ?.map((productJson) => Product.fromJson(productJson))
            .toList() ??
        [];

    return Sale(
      id: json['id'],
      orgId: json['orgId'],
      clientId: json['clientId'],
      type: json['type'],
      products: products,
      total: json['total']?.toDouble() ?? 0.0,
      totalPaid: json['totalPaid']?.toDouble() ?? 0.0,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }
}
