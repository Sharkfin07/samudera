// * Scaffolded with app.quicktype.io
// To parse this JSON data, do
//
//     final globalQuote = globalQuoteFromJson(jsonString);

import 'dart:convert';

GlobalQuote globalQuoteFromJson(String str) =>
    GlobalQuote.fromJson(json.decode(str));

String globalQuoteToJson(GlobalQuote data) => json.encode(data.toJson());

class GlobalQuote {
  String symbol;
  String open;
  String high;
  String low;
  String price;
  String volume;
  DateTime latestTradingDay;
  String previousClose;
  String change;
  String changePercent;

  GlobalQuote({
    required this.symbol,
    required this.open,
    required this.high,
    required this.low,
    required this.price,
    required this.volume,
    required this.latestTradingDay,
    required this.previousClose,
    required this.change,
    required this.changePercent,
  });

  factory GlobalQuote.fromJson(Map<String, dynamic> json) => GlobalQuote(
    symbol: json["symbol"],
    open: json["open"],
    high: json["high"],
    low: json["low"],
    price: json["price"],
    volume: json["volume"],
    latestTradingDay: DateTime.parse(json["latest trading day"]),
    previousClose: json["previous close"],
    change: json["change"],
    changePercent: json["change percent"],
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
    "open": open,
    "high": high,
    "low": low,
    "price": price,
    "volume": volume,
    "latest trading day":
        "${latestTradingDay.year.toString().padLeft(4, '0')}-${latestTradingDay.month.toString().padLeft(2, '0')}-${latestTradingDay.day.toString().padLeft(2, '0')}",
    "previous close": previousClose,
    "change": change,
    "change percent": changePercent,
  };
}
