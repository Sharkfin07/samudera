import 'package:dio/dio.dart';
import 'package:samudera/data/services/api_client.dart';

class StockService {
  StockService({ApiClient? client}) : _client = client ?? ApiClient.instance();
  final ApiClient _client;

  Future<Response<dynamic>> searchStocks(String keywords) {
    return _client.query(
      function: 'SYMBOL_SEARCH',
      parameters: {'keywords': keywords},
    );
  }

  Future<Response<dynamic>> getGlobalQuote(String symbol) {
    return _client.query(
      function: 'GLOBAL_QUOTE',
      parameters: {'symbol': symbol},
    );
  }

  Future<Response<dynamic>> getDailyTimeSeries(
    String symbol, {
    String outputSize = 'compact',
  }) {
    return _client.query(
      function: 'TIME_SERIES_DAILY',
      parameters: {'symbol': symbol, 'outputsize': outputSize},
    );
  }

  Future<Response<dynamic>> getGainersLosersActive({String? entitlement}) {
    final Map<String, String> params = {
      // ignore: use_null_aware_elements
      if (entitlement != null) 'entitlement': entitlement,
    };
    return _client.query(function: "TOP_GAINERS_LOSERS", parameters: params);
  }

  Future<Response<dynamic>> getCompanyOverview(String symbol) {
    return _client.query(function: 'OVERVIEW', parameters: {'symbol': symbol});
  }

  // ! Fallback: fetch multiple quotes (use sparingly, respect rate limits)
  Future<List<Response<dynamic>>> batchQuotes(List<String> symbols) async {
    final List<Response<dynamic>> results = [];
    for (final s in symbols) {
      results.add(await getGlobalQuote(s));
    }
    return results;
  }
}
