import 'package:myapp/features/catalog/domain/entities/supplies.dart';

abstract class SuppliesRepo {
  Future<List<Supply>> fetchSuppliesById(String orgId);
  Future<void> addSupply(Supply supply);
  Future<void> deleteSupply(String supplyId);
}
