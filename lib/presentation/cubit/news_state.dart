part of 'news_cubit.dart';

@immutable
class NewsState {
  final List<News> articles;
  final bool isLoading;
  final String? error;
  final List<String> tickers;
  final List<String> topics;
  final NewsSort sort;
  final int limit;

  const NewsState({
    this.articles = const [],
    this.isLoading = false,
    this.error,
    this.tickers = const [],
    this.topics = const [],
    this.sort = NewsSort.latest,
    this.limit = 20,
  });

  NewsState copyWith({
    List<News>? articles,
    bool? isLoading,
    String? error,
    List<String>? tickers,
    List<String>? topics,
    NewsSort? sort,
    int? limit,
  }) {
    return NewsState(
      articles: articles ?? this.articles,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      tickers: tickers ?? this.tickers,
      topics: topics ?? this.topics,
      sort: sort ?? this.sort,
      limit: limit ?? this.limit,
    );
  }
}
