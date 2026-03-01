import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:samudera/data/services/api_client.dart';
import 'package:samudera/data/services/news_service.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient mockClient;
  late NewsService service;

  setUp(() {
    mockClient = MockApiClient();
    service = NewsService(client: mockClient);
  });

  Response<dynamic> mockResponse(Map<String, dynamic> data) {
    return Response(
      data: data,
      statusCode: 200,
      requestOptions: RequestOptions(path: '/query'),
    );
  }

  group('NewsService', () {
    group('getNewsSentiment', () {
      test('calls query with NEWS_SENTIMENT function', () async {
        // Arrange
        final mockData = {
          'items': '10',
          'sentiment_score_definition': '...',
          'feed': [
            {
              'title': 'Apple stock rises',
              'url': 'https://example.com/news/1',
              'time_published': '20260223T120000',
              'summary': 'Apple Inc saw gains today...',
              'overall_sentiment_score': 0.25,
              'overall_sentiment_label': 'Somewhat-Bullish',
              'ticker_sentiment': [
                {'ticker': 'AAPL', 'relevance_score': '0.9'},
              ],
            },
          ],
        };
        when(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        final response = await service.getNewsSentiment();

        // Assert
        expect(response.statusCode, 200);
        expect(response.data['feed'], isNotEmpty);
        verify(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: any(named: 'parameters'),
          ),
        ).called(1);
      });

      test('includes tickers parameter when provided', () async {
        // Arrange
        final mockData = {'feed': []};
        when(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {'tickers': 'AAPL,MSFT'},
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        await service.getNewsSentiment(tickers: ['AAPL', 'MSFT']);

        // Assert
        verify(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {'tickers': 'AAPL,MSFT'},
          ),
        ).called(1);
      });

      test('includes limit parameter when provided', () async {
        // Arrange
        final mockData = {'feed': []};
        when(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {'limit': '25'},
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        await service.getNewsSentiment(limit: 25);

        // Assert
        verify(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {'limit': '25'},
          ),
        ).called(1);
      });

      test('includes topics parameter when provided', () async {
        // Arrange
        final mockData = {'feed': []};
        when(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {'topics': 'technology,earnings'},
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        await service.getNewsSentiment(topics: ['technology', 'earnings']);

        // Assert
        verify(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {'topics': 'technology,earnings'},
          ),
        ).called(1);
      });

      test('includes sort parameter when provided', () async {
        // Arrange
        final mockData = {'feed': []};
        when(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {'sort': 'RELEVANCE'},
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        await service.getNewsSentiment(sort: NewsSort.relevance);

        // Assert
        verify(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {'sort': 'RELEVANCE'},
          ),
        ).called(1);
      });

      test('includes time range parameters when provided', () async {
        // Arrange
        final mockData = {'feed': []};
        final timeFrom = DateTime.utc(2026, 2, 1);
        final timeTo = DateTime.utc(2026, 2, 23);

        when(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {
              'time_from': timeFrom.toIso8601String(),
              'time_to': timeTo.toIso8601String(),
            },
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        await service.getNewsSentiment(timeFrom: timeFrom, timeTo: timeTo);

        // Assert
        verify(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {
              'time_from': timeFrom.toIso8601String(),
              'time_to': timeTo.toIso8601String(),
            },
          ),
        ).called(1);
      });

      test('includes all parameters when provided', () async {
        // Arrange
        final mockData = {'feed': []};
        final timeFrom = DateTime.utc(2026, 2, 1);
        final timeTo = DateTime.utc(2026, 2, 23);

        when(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {
              'tickers': 'AAPL',
              'limit': '10',
              'sort': 'LATEST',
              'topics': 'technology',
              'time_from': timeFrom.toIso8601String(),
              'time_to': timeTo.toIso8601String(),
            },
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        await service.getNewsSentiment(
          tickers: ['AAPL'],
          limit: 10,
          sort: NewsSort.latest,
          topics: ['technology'],
          timeFrom: timeFrom,
          timeTo: timeTo,
        );

        // Assert
        verify(
          () => mockClient.query<dynamic>(
            function: 'NEWS_SENTIMENT',
            parameters: {
              'tickers': 'AAPL',
              'limit': '10',
              'sort': 'LATEST',
              'topics': 'technology',
              'time_from': timeFrom.toIso8601String(),
              'time_to': timeTo.toIso8601String(),
            },
          ),
        ).called(1);
      });
    });
  });

  group('NewsSort', () {
    test('latest returns LATEST', () {
      expect(NewsSort.latest.value, 'LATEST');
    });

    test('relevance returns RELEVANCE', () {
      expect(NewsSort.relevance.value, 'RELEVANCE');
    });

    test('earliest returns EARLIEST', () {
      expect(NewsSort.earliest.value, 'EARLIEST');
    });
  });
}
