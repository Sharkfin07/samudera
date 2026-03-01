part of 'company_cubit.dart';

@immutable
class CompanyState {
  final String? symbol;
  final Company? company;
  final GlobalQuote? quote;
  final List<({DateTime date, double close})> chartData;
  final bool isLoading;
  final String? error;

  const CompanyState({
    this.symbol,
    this.company,
    this.quote,
    this.chartData = const [],
    this.isLoading = false,
    this.error,
  });

  /// Convenience: true when all core data is available.
  bool get hasData => company != null && quote != null;

  CompanyState copyWith({
    String? symbol,
    Company? company,
    GlobalQuote? quote,
    List<({DateTime date, double close})>? chartData,
    bool? isLoading,
    String? error,
  }) {
    return CompanyState(
      symbol: symbol ?? this.symbol,
      company: company ?? this.company,
      quote: quote ?? this.quote,
      chartData: chartData ?? this.chartData,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
