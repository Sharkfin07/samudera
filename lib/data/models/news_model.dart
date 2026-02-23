// * Scaffolded with app.quicktype.io
// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

News newsModelFromJson(String str) => News.fromJson(json.decode(str));

String newsModelToJson(News data) => json.encode(data.toJson());

class News {
  String title;
  String url;
  String timePublished;
  List<String> authors;
  String summary;
  String bannerImage;
  String source;
  String categoryWithinSource;
  String sourceDomain;
  List<Topic> topics;
  double overallSentimentScore;
  String overallSentimentLabel;
  List<TickerSentiment> tickerSentiment;

  News({
    required this.title,
    required this.url,
    required this.timePublished,
    required this.authors,
    required this.summary,
    required this.bannerImage,
    required this.source,
    required this.categoryWithinSource,
    required this.sourceDomain,
    required this.topics,
    required this.overallSentimentScore,
    required this.overallSentimentLabel,
    required this.tickerSentiment,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    title: json["title"],
    url: json["url"],
    timePublished: json["time_published"],
    authors: List<String>.from(json["authors"].map((x) => x)),
    summary: json["summary"],
    bannerImage: json["banner_image"],
    source: json["source"],
    categoryWithinSource: json["category_within_source"],
    sourceDomain: json["source_domain"],
    topics: List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
    overallSentimentScore: json["overall_sentiment_score"]?.toDouble(),
    overallSentimentLabel: json["overall_sentiment_label"],
    tickerSentiment: List<TickerSentiment>.from(
      json["ticker_sentiment"].map((x) => TickerSentiment.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
    "time_published": timePublished,
    "authors": List<dynamic>.from(authors.map((x) => x)),
    "summary": summary,
    "banner_image": bannerImage,
    "source": source,
    "category_within_source": categoryWithinSource,
    "source_domain": sourceDomain,
    "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
    "overall_sentiment_score": overallSentimentScore,
    "overall_sentiment_label": overallSentimentLabel,
    "ticker_sentiment": List<dynamic>.from(
      tickerSentiment.map((x) => x.toJson()),
    ),
  };
}

class TickerSentiment {
  String ticker;
  String relevanceScore;
  String tickerSentimentScore;
  String tickerSentimentLabel;

  TickerSentiment({
    required this.ticker,
    required this.relevanceScore,
    required this.tickerSentimentScore,
    required this.tickerSentimentLabel,
  });

  factory TickerSentiment.fromJson(Map<String, dynamic> json) =>
      TickerSentiment(
        ticker: json["ticker"],
        relevanceScore: json["relevance_score"],
        tickerSentimentScore: json["ticker_sentiment_score"],
        tickerSentimentLabel: json["ticker_sentiment_label"],
      );

  Map<String, dynamic> toJson() => {
    "ticker": ticker,
    "relevance_score": relevanceScore,
    "ticker_sentiment_score": tickerSentimentScore,
    "ticker_sentiment_label": tickerSentimentLabel,
  };
}

class Topic {
  String topic;
  String relevanceScore;

  Topic({required this.topic, required this.relevanceScore});

  factory Topic.fromJson(Map<String, dynamic> json) =>
      Topic(topic: json["topic"], relevanceScore: json["relevance_score"]);

  Map<String, dynamic> toJson() => {
    "topic": topic,
    "relevance_score": relevanceScore,
  };
}
