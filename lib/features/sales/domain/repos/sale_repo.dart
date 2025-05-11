import 'package:myapp/features/sales/domain/entities/sale.dart';

abstract class SaleRepo {
  Future<void> createSale(Sale sale);
}
