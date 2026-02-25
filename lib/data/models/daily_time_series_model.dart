// * Scaffolded with Claude Opus 4.5

class DailyTimeSeriesResponse {
  final TimeSeriesMetaData metaData;
  final Map<DateTime, DailyOHLC> timeSeries;

  DailyTimeSeriesResponse({required this.metaData, required this.timeSeries});

  factory DailyTimeSeriesResponse.fromJson(Map<String, dynamic> json) {
    final metaJson = json['Meta Data'] as Map<String, dynamic>;
    final seriesJson = json['Time Series (Daily)'] as Map<String, dynamic>;

    // Parse time series: keys are date strings, values are OHLC data
    final Map<DateTime, DailyOHLC> series = {};
    seriesJson.forEach((dateStr, ohlcJson) {
      final date = DateTime.parse(dateStr);
      series[date] = DailyOHLC.fromJson(ohlcJson as Map<String, dynamic>);
    });

    return DailyTimeSeriesResponse(
      metaData: TimeSeriesMetaData.fromJson(metaJson),
      timeSeries: series,
    );
  }

  /// Get sorted list (newest first)
  List<MapEntry<DateTime, DailyOHLC>> get sortedEntries {
    final entries = timeSeries.entries.toList();
    entries.sort((a, b) => b.key.compareTo(a.key)); // descending
    return entries;
  }

  /// Get sorted list (oldest first) -> useful for charts
  List<MapEntry<DateTime, DailyOHLC>> get sortedEntriesAsc {
    final entries = timeSeries.entries.toList();
    entries.sort((a, b) => a.key.compareTo(b.key)); // ascending
    return entries;
  }
}

class TimeSeriesMetaData {
  final String information;
  final String symbol;
  final DateTime lastRefreshed;
  final String outputSize;
  final String timeZone;

  TimeSeriesMetaData({
    required this.information,
    required this.symbol,
    required this.lastRefreshed,
    required this.outputSize,
    required this.timeZone,
  });

  factory TimeSeriesMetaData.fromJson(Map<String, dynamic> json) {
    return TimeSeriesMetaData(
      information: json['1. Information'] as String,
      symbol: json['2. Symbol'] as String,
      lastRefreshed: DateTime.parse(json['3. Last Refreshed'] as String),
      outputSize: json['4. Output Size'] as String,
      timeZone: json['5. Time Zone'] as String,
    );
  }
}

/// OHLC = Open, High, Low, Close + Volume
class DailyOHLC {
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;

  DailyOHLC({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory DailyOHLC.fromJson(Map<String, dynamic> json) {
    return DailyOHLC(
      open: double.parse(json['1. open'] as String),
      high: double.parse(json['2. high'] as String),
      low: double.parse(json['3. low'] as String),
      close: double.parse(json['4. close'] as String),
      volume: int.parse(json['5. volume'] as String),
    );
  }

  /// Price change from open to close
  double get change => close - open;

  /// Percent change from open to close
  double get changePercent => (change / open) * 100;

  /// True if closed higher than opened
  bool get isGain => close > open;
}
