class CoinEntidade {
  final String id;
  final String rank;
  final String symbol;
  final String name;
  final String supply;
  final String maxSupply;
  final String marketCapUsd;
  final double volumeUsd24Hr;
  final double priceUsd;
  final double changePercent24Hr;

  CoinEntidade({
    required this.id,
    required this.rank,
    required this.symbol,
    required this.name,
    required this.supply,
    required this.maxSupply,
    required this.marketCapUsd,
    required this.volumeUsd24Hr,
    required this.priceUsd,
    required this.changePercent24Hr,
  });

  factory CoinEntidade.fromJson(Map<String, dynamic> json) {
    return CoinEntidade(
      id: json['id'],
      rank: json['rank'],
      symbol: json['symbol'],
      name: json['name'],
      supply: json['supply'],
      maxSupply: json['maxSupply'],
      marketCapUsd: json['marketCapUsd'],
      volumeUsd24Hr: double.parse(json['volumeUsd24Hr']),
      priceUsd: double.parse(json['priceUsd']),
      changePercent24Hr: double.parse(json['changePercent24Hr']),
    );
  }
}
