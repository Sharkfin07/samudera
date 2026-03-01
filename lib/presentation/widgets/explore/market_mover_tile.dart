import 'package:flutter/material.dart';
import 'package:samudera/data/models/market_movers_model.dart';

class MarketMoverTile extends StatelessWidget {
  final MarketMover mover;
  final VoidCallback? onTap;

  const MarketMoverTile({super.key, required this.mover, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isPositive = mover.changeAmount >= 0;
    final changeColor = isPositive
        ? const Color(0xFF2E7D32)
        : const Color(0xFFC62828);
    final changeIcon = isPositive ? Icons.trending_up : Icons.trending_down;

    final volumeStr = _formatVolume(mover.volume);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mover.ticker,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Vol: $volumeStr',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),

            // ── Right: Price + Change ──
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  mover.priceFormatted,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(changeIcon, size: 14, color: changeColor),
                    const SizedBox(width: 2),
                    Text(
                      '${mover.changePercentage.toStringAsFixed(4)}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: changeColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Format volume: 1234567 → "1.2M", 12345 → "12.3K"
  static String _formatVolume(int volume) {
    if (volume >= 1000000) {
      return '${(volume / 1000000).toStringAsFixed(1)}M';
    } else if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(1)}K';
    }
    return volume.toString();
  }
}
