import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samudera/core/config/env_config.dart';
import 'package:samudera/data/repositories/stock_search_repository.dart';

void main() async {
  await EnvConfig.load();
  group("Testing the stock search repository", () {
    test("Getting search results", () async {
      final repository = StockSearchRepository();
      final results = await repository.getStockSearchResults(
        "aapl",
      ); // aapl is Apple's symbol btw
      expect(results, isNotNull);
      for (final result in results) {
        debugPrint(result.name);
      }
    });
  });
}
