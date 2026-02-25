import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samudera/core/config/env_config.dart';
import 'package:samudera/data/models/global_quote_model.dart';
import 'package:samudera/data/repositories/global_quote_repository.dart';

Future<void> main() async {
  await EnvConfig.load();
  group("Testing the global quote repository", () {
    test("Getting Apple's Global Quote", () async {
      final repository = GlobalQuoteRepository();
      final response = await repository.getGlobalQuote("AAPL");
      expect(response, isA<GlobalQuote>());

      debugPrint(response.price);
    });
  });
}
