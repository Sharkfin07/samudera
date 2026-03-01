import 'package:flutter/material.dart';
import 'package:samudera/core/utils/is_dark.dart';
import 'package:samudera/data/models/news_model.dart';
import 'package:samudera/presentation/theme/app_palette.dart';
import 'package:samudera/presentation/widgets/global/global_loading_indicator.dart';

class NewsCard extends StatelessWidget {
  final News article;
  final VoidCallback? onTap;

  const NewsCard({super.key, required this.article, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = isDark(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1A1035) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.bannerImage != null && article.bannerImage!.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  article.bannerImage!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const SizedBox(
                      height: 180,
                      child: Center(child: GlobalLoadingIndicator(size: 48)),
                    );
                  },
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              ),

            // ── Content ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sentiment tag + source
                  Row(
                    children: [
                      _SentimentTag(label: article.overallSentimentLabel),
                      const SizedBox(width: 8),
                      Text(
                        '• ${article.source}',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode
                              ? Colors.white.withValues(alpha: 0.5)
                              : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : AppPalette.darkIndigo,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Summary
                  Text(
                    article.summary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDarkMode
                          ? Colors.white.withValues(alpha: 0.6)
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SentimentTag extends StatelessWidget {
  final String label;
  const _SentimentTag({required this.label});

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg) = _sentimentColors(label);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }

  (Color, Color) _sentimentColors(String label) {
    switch (label.toLowerCase()) {
      case 'bullish':
        return (const Color(0xFFE6F9EC), const Color(0xFF1B8A3E));
      case 'somewhat-bullish':
        return (const Color(0xFFE6F9EC), const Color(0xFF3DAF5C));
      case 'bearish':
        return (const Color(0xFFFDE8E8), const Color(0xFFC62828));
      case 'somewhat-bearish':
        return (const Color(0xFFFDE8E8), const Color(0xFFE57373));
      case 'neutral':
      default:
        return (const Color(0xFFF0F0F0), const Color(0xFF616161));
    }
  }
}
