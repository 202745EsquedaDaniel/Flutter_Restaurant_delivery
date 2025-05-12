import 'package:myapp/features/Cajas/domain/entities/caja.dart';
import 'package:myapp/features/Cajas/domain/entities/cajaMovements.dart';

abstract class CajasRepo {
  Future<List<Caja>> getCajaByUserId(String orgId);
}
