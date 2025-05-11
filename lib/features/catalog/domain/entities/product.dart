import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/catalog/domain/entities/packageItem.dart';
import 'package:myapp/features/catalog/domain/entities/supplies.dart';

class Product {
  final String id;
  final String orgId;
  final String type;
  final String name;
  final String description;
  final String categoria;
  final double costo;
  final double price;
  final double? stock;
  final double inventarioMinimo;
  final String unidad;
  final String imageUrl;
  final DateTime timestamp;
  final List<PackageItem>? packageProducts;
  final List<Supply>? supplies;

  Product({
    required this.id,
    required this.orgId,
    required this.type,
    required this.name,
    required this.description,
    required this.categoria,
    required this.costo,
    required this.price,
    this.stock,
    required this.inventarioMinimo,
    required this.unidad,
    required this.imageUrl,
    required this.timestamp,
    this.packageProducts,
    this.supplies,
  });

  // Método copyWith para actualizar valores específicos
  Product copyWith({String? imageUrl}) {
    return Product(
      id: id,
      orgId: orgId,
      type: type,
      name: name,
      description: description,
      categoria: categoria,
      costo: costo,
      price: price,
      stock: stock,
      inventarioMinimo: inventarioMinimo,
      unidad: unidad,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp,
      packageProducts: packageProducts,
      supplies: supplies,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'type': type,
      'name': name,
      'description': description,
      'categoria': categoria,
      'costo': costo,
      'precio': price,
      'stock': stock,
      'unidad': unidad,
      'packageProducts': packageProducts?.map((e) => e.toJson()).toList(),
      'supplies': supplies?.map((e) => e.toJson()).toList(),
      'imageUrl': imageUrl,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // conver Json -< Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      orgId: json['orgId'],
      type: json['type'],
      name: json['name'],
      description: json['description'],
      categoria: json['categoria'],
      costo: (json['costo'] as num).toDouble(),
      price: (json['precio'] as num).toDouble(),
      stock: json['stock'] != null ? (json['stock'] as num).toDouble() : null,
      inventarioMinimo: (json['inventarioMinimo'] as num).toDouble(),
      unidad: json['unidad'],
      imageUrl: json['imageUrl'],
      timestamp:
          json['timestamp'] is Timestamp
              ? (json['timestamp'] as Timestamp).toDate()
              : DateTime.parse(json['timestamp']),
      packageProducts:
          (json['packageProducts'] as List<dynamic>?)
              ?.map((e) => PackageItem.fromJson(e))
              .toList(),
      supplies:
          (json['supplies'] as List<dynamic>?)
              ?.map((e) => Supply.fromJson(e))
              .toList(),
    );
  }
}
