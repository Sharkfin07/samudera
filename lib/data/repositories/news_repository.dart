import 'package:samudera/data/services/news_service.dart';
import 'package:samudera/data/models/news_model.dart';

class NewsRepository {
  NewsRepository({NewsService? service}) : _service = service ?? NewsService();
  final NewsService _service;

  Future<List<News>> getNews({
    int? limit,
    List<String>? topics,
    List<String>? tickers,
    DateTime? timeFrom,
    DateTime? timeTo,
    NewsSort? sort,
  }) async {
    final response = await _service.getNewsSentiment(
      limit: limit,
      topics: topics,
      tickers: tickers,
      timeFrom: timeFrom,
      timeTo: timeTo,
      sort: sort,
    );

    final List<dynamic> feed = response.data['feed'] ?? [];
    return feed.map((json) => News.fromJson(json)).toList();
  }
}
