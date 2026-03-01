// * Scaffolded with Claude Opus 4.6

class MarketMoversResponse {
  final String metadata;
  final String lastUpdated;
  final List<MarketMover> topGainers;
  final List<MarketMover> topLosers;
  final List<MarketMover> mostActivelyTraded;

  const MarketMoversResponse({
    required this.metadata,
    required this.lastUpdated,
    required this.topGainers,
    required this.topLosers,
    required this.mostActivelyTraded,
  });

  factory MarketMoversResponse.fromJson(Map<String, dynamic> json) {
    return MarketMoversResponse(
      metadata: json['metadata'] ?? '',
      lastUpdated: json['last_updated'] ?? '',
      topGainers: _parseList(json['top_gainers']),
      topLosers: _parseList(json['top_losers']),
      mostActivelyTraded: _parseList(json['most_actively_traded']),
    );
  }

  static List<MarketMover> _parseList(dynamic list) {
    if (list == null || list is! List) return [];
    return list.map((e) => MarketMover.fromJson(e)).toList();
  }
}

class MarketMover {
  final String ticker;
  final double price;
  final double changeAmount;
  final double changePercentage;
  final int volume;

  const MarketMover({
    required this.ticker,
    required this.price,
    required this.changeAmount,
    required this.changePercentage,
    required this.volume,
  });

  factory MarketMover.fromJson(Map<String, dynamic> json) {
    return MarketMover(
      ticker: json['ticker'] ?? '',
      price: _toDouble(json['price']),
      changeAmount: _toDouble(json['change_amount']),
      changePercentage: _parsePercent(json['change_percentage']),
      volume: _toInt(json['volume']),
    );
  }

  bool get isGainer => changeAmount > 0;
  bool get isLoser => changeAmount < 0;

  String get priceFormatted => '\$${price.toStringAsFixed(2)}';

  String get changePercentFormatted {
    final sign = changeAmount >= 0 ? '+' : '';
    return '$sign${changePercentage.toStringAsFixed(2)}%';
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  static double _parsePercent(dynamic value) {
    if (value == null) return 0.0;
    final str = value.toString().replaceAll('%', '');
    return double.tryParse(str) ?? 0.0;
  }
}
