// * Scaffolded with app.quicktype.io
// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

// Note: This model intentionally maps only the fields required by the UI.
// Additional JSON fields from the API response are ignored.
class Company {
  String symbol;
  String name;
  double price;
  double changePercent;
  String sector;
  String marketCapitalization;
  String peRatio;
  String dividendYield;
  String description;
  String officialSite;

  Company({
    required this.symbol,
    required this.name,
    required this.price,
    required this.changePercent,
    required this.sector,
    required this.marketCapitalization,
    required this.peRatio,
    required this.dividendYield,
    required this.description,
    required this.officialSite,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    symbol: json["symbol"],
    name: json["name"],
    price: json["price"]?.toDouble(),
    changePercent: json["changePercent"]?.toDouble(),
    sector: json["sector"],
    marketCapitalization: json["marketCapitalization"],
    peRatio: json["peRatio"],
    dividendYield: json["dividendYield"],
    description: json["description"],
    officialSite: json["officialSite"],
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
    "name": name,
    "price": price,
    "changePercent": changePercent,
    "sector": sector,
    "marketCapitalization": marketCapitalization,
    "peRatio": peRatio,
    "dividendYield": dividendYield,
    "description": description,
    "officialSite": officialSite,
  };
}
