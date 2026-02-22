import 'package:flutter_dotenv/flutter_dotenv.dart';

// * The .env holds the api key and the base url for API communication purposes
class EnvConfig {
  static Future<void> load() => dotenv.load(fileName: ".env");

  static String get apiKey =>
      dotenv.env['API_KEY'] ?? (throw Exception("API_KEY not found"));
  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? (throw Exception("BASE_URL not found"));
}
