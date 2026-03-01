import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:samudera/core/utils/is_dark.dart';
import 'package:samudera/data/models/company_model.dart';
import 'package:samudera/data/models/global_quote_model.dart';
import 'package:samudera/presentation/cubit/company_cubit.dart';
import 'package:samudera/presentation/theme/app_palette.dart';
import 'package:samudera/presentation/widgets/global/global_loading_indicator.dart';

class CompanyDetailScreen extends StatelessWidget {
  final String symbol;

  const CompanyDetailScreen({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    // Trigger load on first build (guarded)
    context.read<CompanyCubit>().loadCompany(symbol);

    return Scaffold(
      body: BlocBuilder<CompanyCubit, CompanyState>(
        builder: (context, state) {
          // ── Loading ──
          if (state.isLoading && !state.hasData) {
            return const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlobalLoadingIndicator(),
                  Text("Flying across the atlantic..."),
                ],
              ),
            );
          }

          // ── Error ──
          if (state.error != null && !state.hasData) {
            return _ErrorBody(
              message: state.error!,
              onRetry: () =>
                  context.read<CompanyCubit>().loadCompany(symbol, force: true),
            );
          }

          // ── Data ──
          if (!state.hasData) {
            return const Center(child: Text('No data available.'));
          }

          return _CompanyDetailBody(
            company: state.company!,
            quote: state.quote!,
            chartData: state.chartData,
          );
        },
      ),
    );
  }
}

// ── Main body when data is ready ─────────────────────────────────────────

class _CompanyDetailBody extends StatelessWidget {
  final Company company;
  final GlobalQuote quote;
  final List<({DateTime date, double close})> chartData;

  const _CompanyDetailBody({
    required this.company,
    required this.quote,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = isDark(context);
    final price = double.tryParse(quote.price) ?? 0;
    final change = double.tryParse(quote.change) ?? 0;
    final changePercent = quote.changePercent.replaceAll('%', '');
    final isPositive = change >= 0;
    final changeColor = isPositive
        ? const Color(0xFF2E7D32)
        : const Color(0xFFC62828);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              company.symbol,
              style: const TextStyle(
                fontFamily: 'Garet',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              company.name,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(160),
                fontFamily: "IBMPlexSans",
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: AppPalette.primaryGradient),
        ),
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        color: AppPalette.vividBlue,
        onRefresh: () => context.read<CompanyCubit>().refresh(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // * Price Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1A1035) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Garet',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        color: changeColor,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${isPositive ? '+' : ''}${change.toStringAsFixed(2)} ($changePercent%)',
                        style: TextStyle(
                          color: changeColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // * Chart
            if (chartData.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 24, 32, 8),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1A1035) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: _StockLineChart(
                  chartData: chartData,
                  lineColor: changeColor,
                  isDark: isDarkMode,
                ),
              ),
            ],

            // ── Key Stats ──
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1A1035) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Key Statistics',
                    style: TextStyle(
                      fontFamily: 'Garet',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _StatRow(label: 'Open', value: '\$${quote.open}'),
                  _StatRow(label: 'High', value: '\$${quote.high}'),
                  _StatRow(label: 'Low', value: '\$${quote.low}'),
                  _StatRow(
                    label: 'Prev Close',
                    value: '\$${quote.previousClose}',
                  ),
                  _StatRow(label: 'Volume', value: quote.volume),
                  const Divider(height: 24),
                  _StatRow(label: 'Sector', value: company.sector),
                  _StatRow(label: 'P/E Ratio', value: company.peRatio),
                  _StatRow(
                    label: 'Dividend Yield',
                    value: company.dividendYield,
                  ),
                  _StatRow(
                    label: 'Market Cap',
                    value: _formatMarketCap(company.marketCapitalization),
                  ),
                ],
              ),
            ),

            // ── About ──
            if (company.description.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1A1035) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About',
                      style: TextStyle(
                        fontFamily: 'Garet',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      company.description,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.6,
                        color: isDarkMode ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  static String _formatMarketCap(String raw) {
    final value = double.tryParse(raw);
    if (value == null) return raw;
    if (value >= 1e12) return '\$${(value / 1e12).toStringAsFixed(2)}T';
    if (value >= 1e9) return '\$${(value / 1e9).toStringAsFixed(2)}B';
    if (value >= 1e6) return '\$${(value / 1e6).toStringAsFixed(2)}M';
    return '\$$raw';
  }
}

// ── Stat Row ─────────────────────────────────────────────────────────────

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[500])),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// * Stock Line Chart (fl-chart)
class _StockLineChart extends StatelessWidget {
  final List<({DateTime date, double close})> chartData;
  final Color lineColor;
  final bool isDark;

  const _StockLineChart({
    required this.chartData,
    required this.lineColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (var i = 0; i < chartData.length; i++) {
      spots.add(FlSpot(i.toDouble(), chartData[i].close));
    }

    final closes = chartData.map((e) => e.close);
    final minY = closes.reduce((a, b) => a < b ? a : b);
    final maxY = closes.reduce((a, b) => a > b ? a : b);
    final yPadding = (maxY - minY) * 0.08;

    final gridColor = isDark
        ? Colors.white.withValues(alpha: 0.07)
        : Colors.grey.withValues(alpha: 0.15);
    final labelColor = isDark ? Colors.white54 : Colors.grey;

    final gradientColors = [lineColor, lineColor];

    return AspectRatio(
      aspectRatio: 1.70,
      child: LineChart(
        LineChartData(
          // ── Touch ──
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) =>
                  isDark ? const Color(0xFF2A1F4E) : Colors.white,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final idx = spot.x.toInt().clamp(0, chartData.length - 1);
                  final date = chartData[idx].date;
                  final fmt = DateFormat('d MMM').format(date);
                  return LineTooltipItem(
                    '\$${spot.y.toStringAsFixed(2)}\n',
                    TextStyle(
                      color: lineColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(
                        text: fmt,
                        style: TextStyle(
                          color: labelColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
          ),

          // ── Grid ──
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: _niceInterval(minY, maxY),
            getDrawingHorizontalLine: (value) =>
                FlLine(color: gridColor, strokeWidth: 1),
          ),

          // ── Titles ──
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: _bottomInterval(chartData.length),
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= chartData.length) {
                    return const SizedBox.shrink();
                  }
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      DateFormat('d/M').format(chartData[idx].date),
                      style: TextStyle(color: labelColor, fontSize: 10),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48,
                interval: _niceInterval(minY, maxY),
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(0),
                    style: TextStyle(color: labelColor, fontSize: 10),
                    textAlign: TextAlign.right,
                  );
                },
              ),
            ),
          ),

          // ── Border ──
          borderData: FlBorderData(show: false),

          // ── Range ──
          minX: 0,
          maxX: (chartData.length - 1).toDouble(),
          minY: minY - yPadding,
          maxY: maxY + yPadding,

          // ── Line ──
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              curveSmoothness: 0.25,
              preventCurveOverShooting: true,
              gradient: LinearGradient(colors: gradientColors),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors
                      .map((c) => c.withValues(alpha: 0.15))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  /// Compute a reasonable horizontal grid / label interval.
  static double _niceInterval(double min, double max) {
    final range = max - min;
    if (range <= 0) return 1;
    final raw = range / 5;
    final mag = _pow10((raw.abs()).toString().length - 2);
    return (raw / mag).ceilToDouble() * mag;
  }

  static double _pow10(int exp) {
    if (exp <= 0) return 1;
    return List.filled(exp, 10.0).reduce((a, b) => a * b);
  }

  /// Show ~5 labels spread across the x-axis.
  static double _bottomInterval(int dataLen) {
    if (dataLen <= 5) return 1;
    return (dataLen / 5).floorToDouble();
  }
}

// ── Error body ───────────────────────────────────────────────────────────

class _ErrorBody extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorBody({required this.message, required this.onRetry});

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
              'Failed to load company data',
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
