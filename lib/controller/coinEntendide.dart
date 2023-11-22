class CoinEntidade {
  final String id;
  final String symbol;
  final String name;
  final double priceUsd;

  CoinEntidade({
    required this.id,
    required this.symbol,
    required this.name,
    required this.priceUsd,
  });

  factory CoinEntidade.fromJson(Map<String, dynamic> json) {
    return CoinEntidade(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      priceUsd: double.parse(json['priceUsd']),
    );
  }
}
