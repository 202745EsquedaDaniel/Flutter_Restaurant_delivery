import 'package:cloud_firestore/cloud_firestore.dart';

class CajaMovement {
  final String id;
  final String cajaId;
  final String type; // income, expense, other
  final String? description;
  final double amount;
  final DateTime timestamp;

  CajaMovement({
    required this.id,
    required this.cajaId,
    required this.type,
    this.description,
    required this.amount,
    required this.timestamp,
  });

  CajaMovement copyWith({String? description}) {
    return CajaMovement(
      id: id,
      cajaId: cajaId,
      type: type,
      description: description ?? this.description,
      amount: amount,
      timestamp: timestamp,
    );
  }

  // convert accountmovements -> json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cajaId': cajaId,
      'type': type,
      'description': description,
      'amount': amount,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  // convert json -> accountmovements
  factory CajaMovement.fromJson(Map<String, dynamic> json) {
    return CajaMovement(
      id: json['id'],
      cajaId: json['cajaId'],
      type: json['type'],
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }
}
