class CashReconciliation {
  final String id;
  final String accountId;
  final String createdBy;
  final double initialBalance;
  final double balance;
  final double adjustment;
  final double totalIncome;
  final double totalExpense;
  final DateTime dateTime;
  final DateTime timestamp;
  final String? comment;

  CashReconciliation({
    required this.id,
    required this.accountId,
    required this.createdBy,
    required this.initialBalance,
    required this.balance,
    required this.adjustment,
    required this.totalIncome,
    required this.totalExpense,
    required this.dateTime,
    required this.timestamp,
    this.comment,
  });

  CashReconciliation copyWith() {
    return CashReconciliation(
      id: id,
      accountId: accountId,
      createdBy: createdBy,
      initialBalance: initialBalance,
      balance: balance,
      adjustment: adjustment,
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      dateTime: dateTime,
      timestamp: timestamp,
    );
  }

  // convert cashreconciliation -> json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': accountId,
      'createdBy': createdBy,
      'initialBalance': initialBalance,
      'balance': balance,
      'adjustment': adjustment,
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'dateTime': dateTime.toIso8601String(),
      'timestamp': timestamp.toIso8601String(),
      'comment': comment,
    };
  }

  // convert json -> cashreconciliation
  factory CashReconciliation.fromJson(Map<String, dynamic> json) {
    return CashReconciliation(
      id: json['id'],
      accountId: json['orgId'],
      createdBy: json['createdBy'],
      initialBalance: json['initialBalance'],
      balance: json['balance'],
      adjustment: json['adjustment'],
      totalIncome: json['totalIncome'],
      totalExpense: json['totalExpense'],
      dateTime: DateTime.parse(json['dateTime']),
      timestamp: DateTime.parse(json['timestamp']),
      comment: json['comment'],
    );
  }
}
