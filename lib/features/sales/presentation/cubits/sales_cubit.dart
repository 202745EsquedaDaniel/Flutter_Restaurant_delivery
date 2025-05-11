import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/sales/domain/entities/sale.dart';
import 'package:myapp/features/sales/domain/repos/sale_repo.dart';
import 'package:myapp/features/sales/presentation/cubits/sales_states.dart';

class SalesCubit extends Cubit<SaleState> {
  final SaleRepo saleRepo;

  SalesCubit({required this.saleRepo}) : super(SaleInitial());

  // create a product
  Future<void> createSale(Sale sale) async {
    try {
      emit(SaleUploading());
      // give image url to post
      final newSale = sale.copyWith();

      //  create post in the backend
      saleRepo.createSale(newSale);
    } catch (e) {
      emit(SaleError("Failed to create sale: $e"));
    }
  }
}
