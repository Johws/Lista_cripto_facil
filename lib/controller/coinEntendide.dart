class CoinEntidade {
  final int id;
  final int type;
  final int timestamp;
  final int actionType;
  final double lastTradePrice;
  final int orders;
  final double price;
  final int instrumentId;
  final double quantity;
  final int lanceType;

  CoinEntidade({
    required this.id,
    required this.type,
    required this.timestamp,
    required this.actionType,
    required this.lastTradePrice,
    required this.orders,
    required this.price,
    required this.instrumentId,
    required this.quantity,
    required this.lanceType,
  });

  factory CoinEntidade.fromJson(List<dynamic> json) {
    return CoinEntidade(
      id: json[0] as int,
      type: json[1] as int,
      timestamp: json[2] as int,
      actionType: json[3] as int,
      lastTradePrice: (json[4] as num).toDouble(),
      orders: json[5] as int,
      price: (json[6] as num).toDouble(),
      instrumentId: json[7] as int,
      quantity: (json[8] as num).toDouble(),
      lanceType: json[9] as int,
    );
  }
}
