import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samudera/data/models/company_model.dart';
import 'package:samudera/data/models/global_quote_model.dart';
import 'package:samudera/data/repositories/company_repository.dart';
import 'package:samudera/data/repositories/daily_time_series_repository.dart';
import 'package:samudera/data/repositories/global_quote_repository.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit({
    CompanyRepository? companyRepo,
    GlobalQuoteRepository? quoteRepo,
    DailyTimeSeriesRepository? timeSeriesRepo,
  }) : _companyRepo = companyRepo ?? CompanyRepository(),
       _quoteRepo = quoteRepo ?? GlobalQuoteRepository(),
       _timeSeriesRepo = timeSeriesRepo ?? DailyTimeSeriesRepository(),
       super(const CompanyState());

  final CompanyRepository _companyRepo;
  final GlobalQuoteRepository _quoteRepo;
  final DailyTimeSeriesRepository _timeSeriesRepo;

  /// Fetch all company data (but with a 1.2 second delay from one another)
  Future<void> loadCompany(String symbol, {bool force = false}) async {
    if (state.isLoading) return;
    if (!force && state.symbol == symbol && state.company != null) return;

    emit(CompanyState(symbol: symbol, isLoading: true));

    try {
      // Stagger requests to avoid API rate-limit
      final company = await _companyRepo.getCompany(symbol);
      await Future.delayed(const Duration(milliseconds: 1200));

      final quote = await _quoteRepo.getGlobalQuote(symbol);
      await Future.delayed(const Duration(milliseconds: 1200));

      final chartData = await _timeSeriesRepo.getChartData(symbol, limit: 30);

      emit(
        state.copyWith(
          company: company,
          quote: quote,
          chartData: chartData,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> refresh() {
    if (state.symbol == null) return Future.value();
    return loadCompany(state.symbol!, force: true);
  }

  void clear() => emit(const CompanyState());
}
