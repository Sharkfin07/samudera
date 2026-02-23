// * Scaffolded with app.quicktype.io
// To parse this JSON data, do
//
//     final stockSearchResult = stockSearchResultFromJson(jsonString);

import 'dart:convert';

StockSearchResult stockSearchResultFromJson(String str) =>
    StockSearchResult.fromJson(json.decode(str));

String stockSearchResultToJson(StockSearchResult data) =>
    json.encode(data.toJson());

class StockSearchResult {
  String symbol;
  String name;
  String type;
  String region;
  String marketOpen;
  String marketClose;
  String timezone;
  String currency;
  String matchScore;

  StockSearchResult({
    required this.symbol,
    required this.name,
    required this.type,
    required this.region,
    required this.marketOpen,
    required this.marketClose,
    required this.timezone,
    required this.currency,
    required this.matchScore,
  });

  factory StockSearchResult.fromJson(Map<String, dynamic> json) =>
      StockSearchResult(
        symbol: json["symbol"],
        name: json["name"],
        type: json["type"],
        region: json["region"],
        marketOpen: json["marketOpen"],
        marketClose: json["marketClose"],
        timezone: json["timezone"],
        currency: json["currency"],
        matchScore: json["matchScore"],
      );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
    "name": name,
    "type": type,
    "region": region,
    "marketOpen": marketOpen,
    "marketClose": marketClose,
    "timezone": timezone,
    "currency": currency,
    "matchScore": matchScore,
  };
}
