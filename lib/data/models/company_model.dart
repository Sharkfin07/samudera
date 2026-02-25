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
  String sector;
  String marketCapitalization;
  String peRatio;
  String dividendYield;
  String description;
  String officialSite;

  Company({
    required this.symbol,
    required this.name,
    required this.sector,
    required this.marketCapitalization,
    required this.peRatio,
    required this.dividendYield,
    required this.description,
    required this.officialSite,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    symbol: json["Symbol"],
    name: json["Name"],
    sector: json["Sector"],
    marketCapitalization: json["MarketCapitalization"],
    peRatio: json["PERatio"],
    dividendYield: json["DividendYield"],
    description: json["Description"],
    officialSite: json["OfficialSite"],
  );

  Map<String, dynamic> toJson() => {
    "Symbol": symbol,
    "Name": name,
    "Sector": sector,
    "MarketCapitalization": marketCapitalization,
    "PERatio": peRatio,
    "DividendYield": dividendYield,
    "Description": description,
    "OfficialSite": officialSite,
  };
}
