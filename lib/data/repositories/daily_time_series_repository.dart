import 'package:samudera/data/models/daily_time_series_model.dart';
import 'package:samudera/data/services/stock_service.dart';

class DailyTimeSeriesRepository {
  DailyTimeSeriesRepository({StockService? service})
    : _service = service ?? StockService();
  final StockService _service;

  /// Fetch daily time series for a symbol
  /// [outputSize]: 'compact' (100 data points) or 'full' (20+ years)
  Future<DailyTimeSeriesResponse> getDailyTimeSeries(
    String symbol, {
    String outputSize = 'compact',
  }) async {
    final response = await _service.getDailyTimeSeries(
      symbol,
      outputSize: outputSize,
    );
    final data = response.data;

    if (data is! Map<String, dynamic> || data['Time Series (Daily)'] == null) {
      throw Exception(
        data?['Note'] ?? data?['Information'] ?? 'Invalid response from API',
      );
    }

    return DailyTimeSeriesResponse.fromJson(data);
  }

  /// Get only closing prices (for simple line chart)
  Future<List<double>> getClosingPrices(
    String symbol, {
    String outputSize = 'compact',
    bool ascending = true,
  }) async {
    final data = await getDailyTimeSeries(symbol, outputSize: outputSize);
    final entries = ascending ? data.sortedEntriesAsc : data.sortedEntries;
    return entries.map((e) => e.value.close).toList();
  }

  /// Get chart data points (date + close) for charting libraries
  Future<List<({DateTime date, double close})>> getChartData(
    String symbol, {
    String outputSize = 'compact',
    int? limit,
  }) async {
    final data = await getDailyTimeSeries(symbol, outputSize: outputSize);
    var entries = data.sortedEntriesAsc;

    if (limit != null && limit < entries.length) {
      entries = entries.sublist(entries.length - limit);
    }

    return entries.map((e) => (date: e.key, close: e.value.close)).toList();
  }
}
