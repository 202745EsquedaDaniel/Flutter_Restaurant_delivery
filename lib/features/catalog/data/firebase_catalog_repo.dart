import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/catalog/domain/entities/product.dart';
import 'package:myapp/features/catalog/domain/repos/catalog_repo.dart';

class FirebaseCatalogRepo implements CatalogRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference productsCollection = FirebaseFirestore.instance
      .collection("products");

  @override
  Future<List<Product>> fetchProductsByOrgId(String orgId) async {
    try {
      final productsSnapshot =
          await productsCollection.where("orgId", isEqualTo: orgId).get();

      final products =
          productsSnapshot.docs
              .map(
                (doc) => Product.fromJson(doc.data() as Map<String, dynamic>),
              )
              .toList();

      return products;
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }
}
