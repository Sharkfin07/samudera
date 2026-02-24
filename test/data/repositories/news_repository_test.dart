import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samudera/core/config/env_config.dart';
import 'package:samudera/data/repositories/news_repository.dart';

void main() {
  EnvConfig.load();
  group("Testing the news repository", () {
    test("Getting news", () async {
      final repo = NewsRepository();
      final response = await repo.getNews();

      expect(response, isNotNull);

      for (final n in response) {
        debugPrint(n.title);
      }
    });
  });
}
