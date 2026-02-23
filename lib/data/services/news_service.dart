import 'package:dio/dio.dart';
import 'package:samudera/data/services/api_client.dart';

// Simplify sorting with enumeration
enum NewsSort { latest, relevance, earliest }

extension NewsSortExt on NewsSort {
  String get value {
    switch (this) {
      case NewsSort.latest:
        return 'LATEST';
      case NewsSort.relevance:
        return 'RELEVANCE';
      case NewsSort.earliest:
        return 'EARLIEST';
    }
  }
}

class NewsService {
  NewsService({ApiClient? client}) : _client = client ?? ApiClient.instance();
  final ApiClient _client;

  Future<Response<dynamic>> getNewsSentiment({
    int? limit,
    List<String>? topics,
    List<String>? tickers,
    DateTime? timeFrom,
    DateTime? timeTo,
    NewsSort? sort,
  }) {
    final Map<String, String> params = {
      if (tickers != null) 'tickers': tickers.join(','),
      if (limit != null) 'limit': limit.toString(),
      if (sort != null) 'sort': sort.value,
      if (topics != null) 'topics': topics.join(','),
      if (timeFrom != null) 'time_from': timeFrom.toUtc().toIso8601String(),
      if (timeTo != null) 'time_to': timeTo.toUtc().toIso8601String(),
    };
    return _client.query(function: "NEWS_SENTIMENT", parameters: params);
  }
}
