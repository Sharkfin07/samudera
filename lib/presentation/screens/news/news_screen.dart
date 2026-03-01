import 'package:flutter/material.dart';
import 'package:samudera/data/models/news_model.dart';
import 'package:samudera/presentation/widgets/news/news_card.dart';

final List<News> dummyArticles = [
  News(
    title: 'Apple Reports Record Q4 Earnings Beating Wall Street Expectations',
    url: 'https://example.com/apple-earnings',
    timePublished: '20260228T143000',
    authors: ['John Smith', 'Jane Doe'],
    summary:
        'Apple Inc. reported record fourth-quarter earnings on Friday, surpassing '
        'analyst expectations with strong iPhone and Services revenue. The tech '
        'giant posted earnings per share of \$2.10 on revenue of \$94.9 billion.',
    bannerImage: 'https://picsum.photos/seed/apple/800/400',
    source: 'Bloomberg',
    categoryWithinSource: 'Technology',
    sourceDomain: 'bloomberg.com',
    topics: [
      Topic(topic: 'Technology', relevanceScore: '0.95'),
      Topic(topic: 'Earnings', relevanceScore: '0.88'),
    ],
    overallSentimentScore: 0.35,
    overallSentimentLabel: 'Bullish',
    tickerSentiment: [
      TickerSentiment(
        ticker: 'AAPL',
        relevanceScore: '0.98',
        tickerSentimentScore: '0.42',
        tickerSentimentLabel: 'Bullish',
      ),
    ],
  ),
  News(
    title: 'Federal Reserve Signals Potential Rate Cut Amid Cooling Inflation',
    url: 'https://example.com/fed-rate-cut',
    timePublished: '20260228T100000',
    authors: ['Sarah Johnson'],
    summary:
        'The Federal Reserve indicated it may begin cutting interest rates as '
        'inflation shows signs of cooling. Fed Chair Jerome Powell noted that '
        'recent economic data supports a more accommodative monetary policy stance.',
    bannerImage: 'https://picsum.photos/seed/fed/800/400',
    source: 'Reuters',
    categoryWithinSource: 'Economy',
    sourceDomain: 'reuters.com',
    topics: [
      Topic(topic: 'Economy - Monetary', relevanceScore: '0.99'),
      Topic(topic: 'Financial Markets', relevanceScore: '0.80'),
    ],
    overallSentimentScore: 0.12,
    overallSentimentLabel: 'Somewhat-Bullish',
    tickerSentiment: [],
  ),
  News(
    title: 'Tesla Stock Drops 8% After Missing Delivery Targets for Q1',
    url: 'https://example.com/tesla-drop',
    timePublished: '20260227T183000',
    authors: ['Mike Chen'],
    summary:
        'Tesla shares fell sharply after the EV maker reported quarterly '
        'deliveries below expectations. The company delivered 410,000 vehicles, '
        'missing the consensus estimate of 450,000 units.',
    bannerImage: 'https://picsum.photos/seed/tesla/800/400',
    source: 'CNBC',
    categoryWithinSource: 'Automotive',
    sourceDomain: 'cnbc.com',
    topics: [
      Topic(topic: 'Manufacturing', relevanceScore: '0.90'),
      Topic(topic: 'Technology', relevanceScore: '0.70'),
    ],
    overallSentimentScore: -0.35,
    overallSentimentLabel: 'Bearish',
    tickerSentiment: [
      TickerSentiment(
        ticker: 'TSLA',
        relevanceScore: '0.99',
        tickerSentimentScore: '-0.45',
        tickerSentimentLabel: 'Bearish',
      ),
    ],
  ),
  News(
    title: 'NVIDIA Unveils Next-Gen AI Chip, Stock Surges to All-Time High',
    url: 'https://example.com/nvidia-ai',
    timePublished: '20260227T120000',
    authors: ['Emily Wang', 'David Park'],
    summary:
        'NVIDIA announced its next-generation AI accelerator at the GTC conference, '
        'sending shares to a record high. The new Blackwell Ultra chip promises '
        '4x performance gains for large language model training workloads.',
    bannerImage: 'https://picsum.photos/seed/nvidia/800/400',
    source: 'TechCrunch',
    categoryWithinSource: 'AI & Semiconductors',
    sourceDomain: 'techcrunch.com',
    topics: [
      Topic(topic: 'Technology', relevanceScore: '0.97'),
      Topic(topic: 'Financial Markets', relevanceScore: '0.75'),
    ],
    overallSentimentScore: 0.50,
    overallSentimentLabel: 'Bullish',
    tickerSentiment: [
      TickerSentiment(
        ticker: 'NVDA',
        relevanceScore: '0.99',
        tickerSentimentScore: '0.55',
        tickerSentimentLabel: 'Bullish',
      ),
    ],
  ),
  News(
    title: 'Oil Prices Decline as OPEC+ Increases Production Quotas',
    url: 'https://example.com/oil-opec',
    timePublished: '20260226T090000',
    authors: ['Ahmed Hassan'],
    summary:
        'Crude oil prices fell over 3% after OPEC+ agreed to raise production '
        'quotas starting next month. Brent crude dropped to \$72 per barrel as '
        'markets digest the implications of increased global supply.',
    bannerImage: null,
    source: 'Financial Times',
    categoryWithinSource: 'Energy',
    sourceDomain: 'ft.com',
    topics: [
      Topic(topic: 'Energy & Transportation', relevanceScore: '0.95'),
      Topic(topic: 'Economy - Macro', relevanceScore: '0.65'),
    ],
    overallSentimentScore: -0.15,
    overallSentimentLabel: 'Somewhat-Bearish',
    tickerSentiment: [
      TickerSentiment(
        ticker: 'XOM',
        relevanceScore: '0.80',
        tickerSentimentScore: '-0.20',
        tickerSentimentLabel: 'Somewhat-Bearish',
      ),
      TickerSentiment(
        ticker: 'CVX',
        relevanceScore: '0.75',
        tickerSentimentScore: '-0.18',
        tickerSentimentLabel: 'Somewhat-Bearish',
      ),
    ],
  ),
  News(
    title: 'Microsoft Cloud Revenue Grows 30% YoY Driven by AI Demand',
    url: 'https://example.com/msft-cloud',
    timePublished: '20260225T160000',
    authors: ['Lisa Park'],
    summary:
        'Microsoft reported a 30% year-over-year increase in cloud revenue, '
        'largely driven by growing demand for Azure AI services. The company '
        'saw strong enterprise adoption of its Copilot suite across Office products.',
    bannerImage: 'https://picsum.photos/seed/microsoft/800/400',
    source: 'The Verge',
    categoryWithinSource: 'Technology',
    sourceDomain: 'theverge.com',
    topics: [
      Topic(topic: 'Technology', relevanceScore: '0.92'),
      Topic(topic: 'Earnings', relevanceScore: '0.85'),
    ],
    overallSentimentScore: 0.05,
    overallSentimentLabel: 'Neutral',
    tickerSentiment: [
      TickerSentiment(
        ticker: 'MSFT',
        relevanceScore: '0.97',
        tickerSentimentScore: '0.08',
        tickerSentimentLabel: 'Neutral',
      ),
    ],
  ),
];

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyArticles.length,
        itemBuilder: (context, index) {
          return NewsCard(article: dummyArticles[index]);
        },
      ),
    );
  }
}
