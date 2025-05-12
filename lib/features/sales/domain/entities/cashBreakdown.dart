class CashBreakdown {
  final int bill1000;
  final int bill500;
  final int bill200;
  final int bill100;
  final int bill50;
  final int bill20;
  final int coin10;
  final int coin5;
  final int coin2;
  final int coin1;

  CashBreakdown({
    this.bill1000 = 0,
    this.bill500 = 0,
    this.bill200 = 0,
    this.bill100 = 0,
    this.bill50 = 0,
    this.bill20 = 0,
    this.coin10 = 0,
    this.coin5 = 0,
    this.coin2 = 0,
    this.coin1 = 0,
  });

  CashBreakdown copyWith() {
    return CashBreakdown(
      bill1000: bill1000,
      bill500: bill500,
      bill200: bill200,
      bill100: bill100,
      bill50: bill50,
      bill20: bill20,
      coin10: coin10,
      coin5: coin5,
      coin2: coin2,
      coin1: coin1,
    );
  }

  // convert cashbreakdown -> json
  Map<String, dynamic> toJson() {
    return {
      'bill1000': bill1000,
      'bill500': bill500,
      'bill200': bill200,
      'bill100': bill100,
      'bill50': bill50,
      'bill20': bill20,
      'coin10': coin10,
      'coin5': coin5,
      'coin2': coin2,
      'coin1': coin1,
    };
  }

  // convert json -> cashbreakdown
  factory CashBreakdown.fromJson(Map<String, dynamic> json) {
    return CashBreakdown(
      bill1000: json['bill1000'] ?? 0,
      bill500: json['bill500'] ?? 0,
      bill200: json['bill200'] ?? 0,
      bill100: json['bill100'] ?? 0,
      bill50: json['bill50'] ?? 0,
      bill20: json['bill20'] ?? 0,
      coin10: json['coin10'] ?? 0,
      coin5: json['coin5'] ?? 0,
      coin2: json['coin2'] ?? 0,
      coin1: json['coin1'] ?? 0,
    );
  }
}
