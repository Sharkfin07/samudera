import 'package:samudera/data/models/company_model.dart';
import 'package:samudera/data/services/stock_service.dart';

class CompanyRepository {
  CompanyRepository({StockService? service})
    : _service = service ?? StockService();
  final StockService _service;

  Future<Company> getCompany(String symbol) async {
    final response = await _service.getCompanyOverview(symbol);
    final data = response.data;

    if (data is! Map<String, dynamic> || data['Symbol'] == null) {
      throw Exception(
        data?['Note'] ?? data?['Information'] ?? 'Invalid response from API',
      );
    }

    return Company.fromJson(data);
  }
}
