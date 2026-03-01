import 'package:samudera/data/models/global_quote_model.dart';
import 'package:samudera/data/services/stock_service.dart';

class GlobalQuoteRepository {
  GlobalQuoteRepository({StockService? service})
    : _service = service ?? StockService();
  final StockService _service;

  Future<GlobalQuote> getGlobalQuote(String symbol) async {
    final response = await _service.getGlobalQuote(symbol);
    final data = response.data;

    if (data is! Map<String, dynamic> || data['Global Quote'] == null) {
      throw Exception(
        data?['Note'] ?? data?['Information'] ?? 'Invalid response from API',
      );
    }

    return GlobalQuote.fromJson(data['Global Quote'] as Map<String, dynamic>);
  }
}
