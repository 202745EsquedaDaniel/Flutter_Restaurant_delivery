import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:myapp/features/catalog/domain/entities/packageItem.dart';
import 'package:myapp/features/sales/domain/entities/sale.dart';
import 'package:myapp/features/sales/domain/repos/sale_repo.dart';
import 'package:myapp/features/catalog/domain/entities/product.dart';
import 'package:myapp/features/catalog/domain/entities/supplies.dart';

class FirebaseSalesRepo implements SaleRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final HttpsCallable callableCreateSale = FirebaseFunctions.instance
      .httpsCallable('createSale');

  // documentado paso por paso ya que es un proceso largo
  @override
  Future<void> createSale(Sale sale) async {
    try {
      final functions = FirebaseFunctions.instance;

      final result = await functions.httpsCallable('createSale').call(
        <String, dynamic>{
          'sale': sale.toJson(), // asegúrate de tener toJson() implementado
        },
      );

      final data = result.data;
      if (data['success'] == true) {
        print("✅ Venta creada con éxito: ${data['message']}");
      } else {
        print("⚠️ Fallo al crear la venta");
      }
    } on FirebaseFunctionsException catch (e) {
      print("🚨 FirebaseFunctionsException: ${e.message}");
    } catch (e) {
      print("🚨 Error inesperado: $e");
    }
  }
}
