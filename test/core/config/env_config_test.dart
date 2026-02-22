import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samudera/core/config/env_config.dart';

Future<void> main() async {
  await EnvConfig.load(); // Load it first

  group("Get API_KEY and BASE_URL", () {
    test("Expect API_KEY", () {
      String apiKey = EnvConfig.apiKey;
      expect(apiKey, anything);
      debugPrint(apiKey);
    });

    test("Expect BASE_URL", () {
      String baseUrl = EnvConfig.baseUrl;
      expect(baseUrl, anything);
      debugPrint(baseUrl);
    });
  });
}
