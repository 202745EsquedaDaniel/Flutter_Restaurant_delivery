import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/catalog/domain/entities/product.dart';
import 'package:myapp/features/sales/domain/entities/cashBreakdown.dart';

class Sale {
  final String id;
  final String orgId;
  final String clientId;
  final String? saleId;
  final String? cajaId;
  final String type;
  final List<Product> products;
  final double total;
  final CashBreakdown? cashBreakdown;
  final double totalPaid;
  final DateTime timestamp;

  Sale({
    required this.id,
    required this.orgId,
    this.saleId,
    this.cajaId,
    required this.type,
    required this.products,
    required this.clientId,
    required this.total,
    this.cashBreakdown,
    required this.totalPaid,
    required this.timestamp,
  });

  Sale copyWith() {
    return Sale(
      id: id,
      orgId: orgId,
      clientId: clientId,
      saleId: saleId,
      cajaId: cajaId,
      type: type,
      products: products,
      total: total,
      totalPaid: totalPaid,
      cashBreakdown: cashBreakdown,
      timestamp: timestamp,
    );
  }

  // convert sale -> json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'clientId': clientId,
      'saleId': saleId,
      'cajaId': cajaId,
      'type': type,
      'products': products.map((product) => product.toJson()).toList(),
      'total': total,
      'totalPaid': totalPaid,
      'cashBreakdown': cashBreakdown?.toJson(),
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
      saleId: json['saleId'],
      cajaId: json['cajaId'],
      type: json['type'],
      products: products,
      total: json['total']?.toDouble() ?? 0.0,
      totalPaid: json['totalPaid']?.toDouble() ?? 0.0,
      cashBreakdown:
          json['cashBreakdown'] != null
              ? CashBreakdown.fromJson(json['cashBreakdown'])
              : null,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }
}
