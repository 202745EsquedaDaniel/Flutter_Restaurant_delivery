import 'package:myapp/features/sales/domain/entities/sale.dart';

abstract class SaleState {}

// initial
class SaleInitial extends SaleState {}

// loading...
class SalesLoading extends SaleState {}

// uploading...
class SaleUploading extends SaleState {}

// error
class SaleError extends SaleState {
  final String message;
  SaleError(this.message);
}

// loaded
class SalesLoaded extends SaleState {
  final List<Sale> sales;
  SalesLoaded(this.sales);
}
