import 'package:myapp/features/catalog/domain/entities/packageItem.dart';
import 'package:myapp/features/catalog/domain/entities/product.dart';

abstract class CatalogState {}

// initial
class CatalogInitial extends CatalogState {}

// loading...
class CatalogLoading extends CatalogState {}

// uploading...
class CatalogUploading extends CatalogState {}

// loaded
class CatalogLoaded extends CatalogState {
  final List<Product> products;
  CatalogLoaded(this.products);
}

// error
class CatalogError extends CatalogState {
  final String message;
  CatalogError(this.message);
}

class ProductsForPackageSelected extends CatalogState {
  final List<PackageItem> selectedItems;
  ProductsForPackageSelected(this.selectedItems);
}
