class Caja {
  final String id;
  final String orgId;
  final String? description;
  final DateTime lastUpdated;
  final DateTime createdAt;

  // constructor
  Caja({
    required this.id,
    required this.orgId,
    this.description,
    required this.lastUpdated,
    required this.createdAt,
  });

  Caja copyWith() {
    return Caja(
      id: id,
      orgId: orgId,
      description: description ?? this.description,
      lastUpdated: lastUpdated,
      createdAt: createdAt,
    );
  }

  // convert caja -> json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'description': description,
      'lastUpdated': lastUpdated.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // convert json -> caja
  factory Caja.fromJson(Map<String, dynamic> json) {
    return Caja(
      id: json['id'],
      orgId: json['orgId'],
      description: json['description'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
