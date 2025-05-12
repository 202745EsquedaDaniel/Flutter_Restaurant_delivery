import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/features/Cajas/domain/entities/caja.dart';
import 'package:myapp/features/Cajas/domain/entities/cajaMovements.dart';
import 'package:myapp/features/Cajas/domain/repos/cajas_repo.dart';

class FirebaseCajasRepo implements CajasRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // store the accounts in a collection called "accounts"
  final CollectionReference cajasCollection = FirebaseFirestore.instance
      .collection('registers');
  // store the movements in a collection called "movements"
  final CollectionReference movementsCollection = FirebaseFirestore.instance
      .collection('movements');

  @override
  Future<List<Caja>> getCajaByUserId(String orgId) async {
    try {
      final cajasSnapshot =
          await cajasCollection.where("orgId", isEqualTo: orgId).get();

      final List<Caja> allCajas =
          cajasSnapshot.docs
              .map((doc) => Caja.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

      return allCajas;
    } catch (e) {
      throw Exception("Error fetching cajas: $e");
    }
  }

  // fetch movements by date day selected
  // Primer indice de nuestra base de datos en firebase
  @override
  Future<List<CajaMovement>> getMovementsByDate(
    String cajaId,
    DateTime date,
  ) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final movementsSnapshot =
          await movementsCollection
              .where("cajaId", isEqualTo: cajaId)
              .where("timestamp", isGreaterThanOrEqualTo: startOfDay)
              .where("timestamp", isLessThanOrEqualTo: endOfDay)
              .get();

      final List<CajaMovement> allMovements =
          movementsSnapshot.docs
              .map(
                (doc) =>
                    CajaMovement.fromJson(doc.data() as Map<String, dynamic>),
              )
              .toList();

      return allMovements;
    } catch (e) {
      throw Exception("Error fetching movements: $e");
    }
  }
}
