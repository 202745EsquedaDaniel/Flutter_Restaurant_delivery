import 'package:myapp/features/catalog/domain/entities/packageItem.dart';

abstract class PackageProductsRepo {
  Future<List<PackageItem>> fetchProductsById(String orgId);
}
