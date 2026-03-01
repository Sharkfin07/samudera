import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samudera/data/models/market_movers_model.dart';
import 'package:samudera/data/repositories/market_movers_repository.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit({MarketMoversRepository? repository})
    : _repository = repository ?? MarketMoversRepository(),
      super(const ExploreState());

  final MarketMoversRepository _repository;

  /// Fetch once to get losers, tops, and actives (biar hemat token cui)
  Future<void> fetchMarketMovers({bool force = false}) async {
    if (state.isLoading) return;
    if (!force &&
        (state.gainers.isNotEmpty ||
            state.losers.isNotEmpty ||
            state.active.isNotEmpty)) {
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));
    try {
      final response = await _repository.getMarketMovers();
      emit(
        state.copyWith(
          gainers: response.topGainers,
          losers: response.topLosers,
          active: response.mostActivelyTraded,
          lastUpdated: response.lastUpdated,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// Switch tab without fetching again
  void switchTab(MarketTab tab) {
    if (state.selectedTab == tab) return;
    emit(state.copyWith(selectedTab: tab));
  }

  Future<void> refresh() => fetchMarketMovers(force: true);
}
