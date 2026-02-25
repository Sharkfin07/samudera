import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samudera/core/config/env_config.dart';
import 'package:samudera/data/models/daily_time_series_model.dart';
import 'package:samudera/data/repositories/daily_time_series_repository.dart';

void main() async {
  await EnvConfig.load();
  group("Testing the daily time series repository", () {
    final repository = DailyTimeSeriesRepository();
    test("Get daily time series of Microsoft", () async {
      final response = await repository.getDailyTimeSeries("MSFT");
      expect(response, isA<DailyTimeSeriesResponse>());
    });
    test("Get closing prices for Google", () async {
      final response = await repository.getClosingPrices("GOOGL");
      debugPrint(response.toString());
    });
    test("Get chart data for Amazon", () async {
      final response = await repository.getChartData("AMZN");
      debugPrint(response.toString());
    });
  });
}
