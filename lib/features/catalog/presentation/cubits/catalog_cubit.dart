import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/catalog/domain/entities/packageItem.dart';
import 'package:myapp/features/catalog/domain/repos/catalog_repo.dart';
import 'package:myapp/features/catalog/presentation/cubits/catalog_states.dart';

class CatalogCubit extends Cubit<CatalogState> {
  final CatalogRepo catalogRepo;

  List<PackageItem> selectedPackageProducts = [];

  CatalogCubit({required this.catalogRepo}) : super(CatalogInitial());

  // fetch products by orgId
  Future<void> fetchProductsByOrgId(String orgId) async {
    try {
      emit(CatalogLoading());
      final products = await catalogRepo.fetchProductsByOrgId(orgId);
      emit(CatalogLoaded(products));
    } catch (e) {
      emit(CatalogError("Failed to fetch products: $e"));
    }
  }
}
