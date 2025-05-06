import 'package:myapp/features/catalog/domain/entities/product.dart';

abstract class CatalogRepo {
  Future<List<Product>> fetchProductsByOrgId(String orgId);
}
