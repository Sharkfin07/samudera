import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samudera/data/models/news_model.dart';
import 'package:samudera/data/repositories/news_repository.dart';
import 'package:samudera/data/services/news_service.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({NewsRepository? repository})
    : _repository = repository ?? NewsRepository(),
      super(const NewsState());

  final NewsRepository _repository;

  Future<void> fetchNews() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final articles = await _repository.getNews(
        limit: state.limit,
        tickers: state.tickers.isNotEmpty ? state.tickers : null,
        topics: state.topics.isNotEmpty ? state.topics : null,
        sort: state.sort,
      );
      emit(state.copyWith(articles: articles, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> refresh() => fetchNews();

  void setTickers(List<String> tickers) {
    emit(state.copyWith(tickers: tickers));
    fetchNews();
  }

  void addTicker(String ticker) {
    final upper = ticker.toUpperCase();
    if (!state.tickers.contains(upper)) {
      emit(state.copyWith(tickers: [...state.tickers, upper]));
      fetchNews();
    }
  }

  void removeTicker(String ticker) {
    final updated = state.tickers
        .where((t) => t != ticker.toUpperCase())
        .toList();
    emit(state.copyWith(tickers: updated));
    fetchNews();
  }

  void clearTickers() {
    emit(state.copyWith(tickers: []));
    fetchNews();
  }

  void setTopics(List<String> topics) {
    emit(state.copyWith(topics: topics));
    fetchNews();
  }

  void setSort(NewsSort sort) {
    if (state.sort == sort) return;
    emit(state.copyWith(sort: sort));
    fetchNews();
  }

  void setLimit(int limit) {
    emit(state.copyWith(limit: limit));
    fetchNews();
  }
}
