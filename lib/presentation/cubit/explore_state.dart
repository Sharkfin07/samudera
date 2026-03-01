part of 'explore_cubit.dart';

enum MarketTab { gainers, losers, active }

@immutable
class ExploreState {
  final List<MarketMover> gainers;
  final List<MarketMover> losers;
  final List<MarketMover> active;
  final MarketTab selectedTab;
  final bool isLoading;
  final String? error;
  final String? lastUpdated;

  const ExploreState({
    this.gainers = const [],
    this.losers = const [],
    this.active = const [],
    this.selectedTab = MarketTab.gainers,
    this.isLoading = false,
    this.error,
    this.lastUpdated,
  });

  List<MarketMover> get currentList {
    switch (selectedTab) {
      case MarketTab.gainers:
        return gainers;
      case MarketTab.losers:
        return losers;
      case MarketTab.active:
        return active;
    }
  }

  ExploreState copyWith({
    List<MarketMover>? gainers,
    List<MarketMover>? losers,
    List<MarketMover>? active,
    MarketTab? selectedTab,
    bool? isLoading,
    String? error,
    String? lastUpdated,
  }) {
    return ExploreState(
      gainers: gainers ?? this.gainers,
      losers: losers ?? this.losers,
      active: active ?? this.active,
      selectedTab: selectedTab ?? this.selectedTab,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
