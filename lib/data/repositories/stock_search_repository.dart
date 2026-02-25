import 'package:samudera/data/models/stock_search_model.dart';
import 'package:samudera/data/services/stock_service.dart';

class StockSearchRepository {
  StockSearchRepository({StockService? service})
    : _service = service ?? StockService();
  final StockService _service;

  Future<List<StockSearchResult>> getStockSearchResults(String keywords) async {
    final response = await _service.searchStocks(keywords);

    final List<dynamic> bestMatches = response.data['bestMatches'] ?? [];
    return bestMatches.map((json) => StockSearchResult.fromJson(json)).toList();
  }
}
