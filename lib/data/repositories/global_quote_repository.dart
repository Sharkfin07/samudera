import 'package:samudera/data/models/global_quote_model.dart';
import 'package:samudera/data/services/stock_service.dart';

class GlobalQuoteRepository {
  GlobalQuoteRepository({StockService? service})
    : _service = service ?? StockService();
  final StockService _service;

  Future<GlobalQuote> getGlobalQuote(String symbol) async {
    final response = await _service.getGlobalQuote(symbol);
    return GlobalQuote.fromJson(response.data["Global Quote"]);
  }
}
