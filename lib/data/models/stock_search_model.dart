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
        symbol: json["1. symbol"],
        name: json["2. name"],
        type: json["3. type"],
        region: json["4. region"],
        marketOpen: json["5. marketOpen"],
        marketClose: json["6. marketClose"],
        timezone: json["7. timezone"],
        currency: json["8. currency"],
        matchScore: json["9. matchScore"],
      );

  Map<String, dynamic> toJson() => {
    "1. symbol": symbol,
    "2. name": name,
    "3. type": type,
    "4. region": region,
    "5. marketOpen": marketOpen,
    "6. marketClose": marketClose,
    "7. timezone": timezone,
    "8. currency": currency,
    "9. matchScore": matchScore,
  };
}
