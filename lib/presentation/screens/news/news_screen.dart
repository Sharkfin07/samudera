import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samudera/core/utils/is_dark.dart';
import 'package:samudera/data/services/news_service.dart';
import 'package:samudera/presentation/cubit/news_cubit.dart';
import 'package:samudera/presentation/theme/app_palette.dart';
import 'package:samudera/presentation/widgets/global/global_loading_indicator.dart';
import 'package:samudera/presentation/widgets/global/global_sliver_app_bar.dart';
import 'package:samudera/presentation/widgets/news/news_card.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = isDark(context);
    final String heroImage =
        "assets/images/hero-image-${isDarkMode ? "2" : "1"}.jpg";
    final String heroTitle = "News";
    final String heroDesc = 'Get market insights & updates.';
    final IconData heroIcon = Icons.newspaper;

    return Scaffold(
      body: RefreshIndicator(
        color: AppPalette.vividBlue,
        onRefresh: () => context.read<NewsCubit>().refresh(),
        child: CustomScrollView(
          slivers: [
            GlobalSliverAppBar(
              heroImage: heroImage,
              heroTitle: heroTitle,
              heroDesc: heroDesc,
              heroIcon: heroIcon,
            ),
            SliverToBoxAdapter(
              child: BlocSelector<NewsCubit, NewsState, NewsSort>(
                selector: (state) => state.sort,
                builder: (context, currentSort) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(10, 12, 16, 4),
                    child: Row(
                      children: NewsSort.values.map((sort) {
                        final isSelected = sort == currentSort;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(_sortLabel(sort)),
                            selected: isSelected,
                            onSelected: (_) =>
                                context.read<NewsCubit>().setSort(sort),
                            selectedColor: AppPalette.vividBlue,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : null,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                            side: isSelected
                                ? BorderSide.none
                                : BorderSide(
                                    color: isDarkMode
                                        ? Colors.white24
                                        : Colors.black12,
                                  ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),

            BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                // Loading
                if (state.isLoading && state.articles.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GlobalLoadingIndicator(
                            variant: LoadingIndicatorVariant.plane,
                            size: 256,
                          ),
                          SizedBox(height: 0),
                          Text(
                            "Crossing the ocean...",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Error
                if (state.error != null && state.articles.isEmpty) {
                  return SliverFillRemaining(
                    child: _ErrorView(
                      message: state.error!,
                      onRetry: () => context.read<NewsCubit>().refresh(),
                    ),
                  );
                }

                // Empty
                if (state.articles.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No articles found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  );
                }

                // Article list
                return SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList.builder(
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      return NewsCard(article: state.articles[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static String _sortLabel(NewsSort sort) {
    switch (sort) {
      case NewsSort.latest:
        return 'Latest';
      case NewsSort.relevance:
        return 'Relevance';
      case NewsSort.earliest:
        return 'Earliest';
    }
  }
}

// ── Error widget (private) ───────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Failed to load news',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
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
}
