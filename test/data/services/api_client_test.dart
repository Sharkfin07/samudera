import 'package:flutter_test/flutter_test.dart';
import 'package:samudera/core/config/env_config.dart';
import 'package:samudera/data/services/api_client.dart';

Future<void> main() async {
  await EnvConfig.load();
  group("Test calling the API", () {
    test("Tracking CS majors", () async {
      final apiClient = ApiClient.instance();
      final response = await apiClient.query(function: "UNEMPLOYMENT");
      expect(response.data, isNotNull);
    }); // just kidding kak

    test("Get intraday stocks", () async {
      final apiClient = ApiClient.instance();
      final response = await apiClient.query(
        function: "TIME_SERIES_INTRADAY",
        parameters: {"SYMBOL": "IBM", "INTERVAL": "1min"},
      );
      expect(response, isNotNull);
    });
  });
}
