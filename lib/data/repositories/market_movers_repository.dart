import 'package:samudera/data/models/market_movers_model.dart';
import 'package:samudera/data/services/stock_service.dart';

class MarketMoversRepository {
  MarketMoversRepository({StockService? service})
    : _service = service ?? StockService();

  final StockService _service;

  /// Fetch top gainers, losers, and most actively traded.
  Future<MarketMoversResponse> getMarketMovers({String? entitlement}) async {
    final response = await _service.getGainersLosersActive(
      entitlement: entitlement,
    );
    return MarketMoversResponse.fromJson(response.data);
  }

  /// Fetch only top gainers.
  Future<List<MarketMover>> getTopGainers({String? entitlement}) async {
    final data = await getMarketMovers(entitlement: entitlement);
    return data.topGainers;
  }

  /// Fetch only top losers.
  Future<List<MarketMover>> getTopLosers({String? entitlement}) async {
    final data = await getMarketMovers(entitlement: entitlement);
    return data.topLosers;
  }

  /// Fetch only most actively traded.
  Future<List<MarketMover>> getMostActive({String? entitlement}) async {
    final data = await getMarketMovers(entitlement: entitlement);
    return data.mostActivelyTraded;
  }
}
