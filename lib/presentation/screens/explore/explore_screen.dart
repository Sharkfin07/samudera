import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samudera/core/utils/is_dark.dart';
import 'package:samudera/presentation/cubit/explore_cubit.dart';
import 'package:samudera/presentation/theme/app_palette.dart';
import 'package:samudera/presentation/widgets/explore/market_mover_tile.dart';
import 'package:samudera/presentation/widgets/global/global_loading_indicator.dart';
import 'package:samudera/presentation/widgets/global/global_sliver_app_bar.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = isDark(context);

    return Scaffold(
      body: RefreshIndicator(
        color: AppPalette.vividBlue,
        onRefresh: () => context.read<ExploreCubit>().refresh(),
        child: CustomScrollView(
          slivers: [
            GlobalSliverAppBar(
              heroImage: "assets/images/hero-image-3.jpg",
              heroTitle: "Explore",
              heroDesc: "Be updated on today's top performers.",
              heroIcon: Icons.public,
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: BlocSelector<ExploreCubit, ExploreState, MarketTab>(
                  selector: (state) => state.selectedTab,
                  builder: (context, selectedTab) {
                    return Container(
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: 0.06)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: MarketTab.values.map((tab) {
                          final isSelected = tab == selectedTab;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  context.read<ExploreCubit>().switchTab(tab),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? (isDarkMode
                                            ? AppPalette.vividIndigo
                                            : Colors.white)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.08,
                                            ),
                                            blurRadius: 4,
                                            offset: const Offset(0, 1),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    _tabLabel(tab),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? (isDarkMode
                                                ? Colors.white
                                                : AppPalette.vividIndigo)
                                          : Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
            ),

            BlocBuilder<ExploreCubit, ExploreState>(
              builder: (context, state) {
                // Loading
                if (state.isLoading && state.currentList.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: GlobalLoadingIndicator()),
                  );
                }

                // Error
                if (state.error != null && state.currentList.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.cloud_off_rounded,
                            size: 56,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Failed to load market data',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            onPressed: () =>
                                context.read<ExploreCubit>().refresh(),
                            icon: const Icon(Icons.refresh, size: 18),
                            label: const Text('Retry'),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppPalette.vividBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Empty
                if (state.currentList.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No data available.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  );
                }

                // List
                return SliverList.separated(
                  itemCount: state.currentList.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    return MarketMoverTile(mover: state.currentList[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static String _tabLabel(MarketTab tab) {
    switch (tab) {
      case MarketTab.gainers:
        return 'Gainers';
      case MarketTab.losers:
        return 'Losers';
      case MarketTab.active:
        return 'Active';
    }
  }
}
