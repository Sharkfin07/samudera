import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:samudera/data/services/api_client.dart';
import 'package:samudera/data/services/stock_service.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient mockClient;
  late StockService service;

  setUp(() {
    mockClient = MockApiClient();
    service = StockService(client: mockClient);
  });

  Response<dynamic> mockResponse(Map<String, dynamic> data) {
    return Response(
      data: data,
      statusCode: 200,
      requestOptions: RequestOptions(path: '/query'),
    );
  }

  group('StockService', () {
    group('searchStocks', () {
      test('calls query with SYMBOL_SEARCH function and keywords', () async {
        // Arrange
        final mockData = {
          'bestMatches': [
            {'1. symbol': 'AAPL', '2. name': 'Apple Inc'},
          ],
        };
        when(
          () => mockClient.query<dynamic>(
            function: 'SYMBOL_SEARCH',
            parameters: {'keywords': 'apple'},
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        final response = await service.searchStocks('apple');

        // Assert
        expect(response.statusCode, 200);
        expect(response.data['bestMatches'], isNotEmpty);
        verify(
          () => mockClient.query<dynamic>(
            function: 'SYMBOL_SEARCH',
            parameters: {'keywords': 'apple'},
          ),
        ).called(1);
      });
    });

    group('getGlobalQuote', () {
      test('calls query with GLOBAL_QUOTE function and symbol', () async {
        // Arrange
        final mockData = {
          'Global Quote': {
            '01. symbol': 'AAPL',
            '05. price': '150.00',
            '10. change percent': '1.5%',
          },
        };
        when(
          () => mockClient.query<dynamic>(
            function: 'GLOBAL_QUOTE',
            parameters: {'symbol': 'AAPL'},
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        final response = await service.getGlobalQuote('AAPL');

        // Assert
        expect(response.statusCode, 200);
        expect(response.data['Global Quote']['01. symbol'], 'AAPL');
        verify(
          () => mockClient.query<dynamic>(
            function: 'GLOBAL_QUOTE',
            parameters: {'symbol': 'AAPL'},
          ),
        ).called(1);
      });
    });

    group('getDailyTimeSeries', () {
      test(
        'calls query with TIME_SERIES_DAILY and default outputsize',
        () async {
          // Arrange
          final mockData = {
            'Meta Data': {'2. Symbol': 'MSFT'},
            'Time Series (Daily)': {
              '2026-02-23': {'1. open': '400.00', '4. close': '405.00'},
            },
          };
          when(
            () => mockClient.query<dynamic>(
              function: 'TIME_SERIES_DAILY',
              parameters: {'symbol': 'MSFT', 'outputsize': 'compact'},
            ),
          ).thenAnswer((_) async => mockResponse(mockData));

          // Act
          final response = await service.getDailyTimeSeries('MSFT');

          // Assert
          expect(response.statusCode, 200);
          expect(response.data['Meta Data']['2. Symbol'], 'MSFT');
          verify(
            () => mockClient.query<dynamic>(
              function: 'TIME_SERIES_DAILY',
              parameters: {'symbol': 'MSFT', 'outputsize': 'compact'},
            ),
          ).called(1);
        },
      );

      test('calls query with full outputsize when specified', () async {
        // Arrange
        final mockData = {'Meta Data': {}, 'Time Series (Daily)': {}};
        when(
          () => mockClient.query<dynamic>(
            function: 'TIME_SERIES_DAILY',
            parameters: {'symbol': 'MSFT', 'outputsize': 'full'},
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        await service.getDailyTimeSeries('MSFT', outputSize: 'full');

        // Assert
        verify(
          () => mockClient.query<dynamic>(
            function: 'TIME_SERIES_DAILY',
            parameters: {'symbol': 'MSFT', 'outputsize': 'full'},
          ),
        ).called(1);
      });
    });

    group('getGainersLosersActive', () {
      test('calls query with TOP_GAINERS_LOSERS without entitlement', () async {
        // Arrange
        final mockData = {
          'top_gainers': [
            {'ticker': 'XYZ', 'price': '10.00', 'change_percentage': '50%'},
          ],
          'top_losers': [],
          'most_actively_traded': [],
        };
        when(
          () => mockClient.query<dynamic>(
            function: 'TOP_GAINERS_LOSERS',
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        final response = await service.getGainersLosersActive();

        // Assert
        expect(response.statusCode, 200);
        expect(response.data['top_gainers'], isNotEmpty);
      });

      test('calls query with realtime entitlement', () async {
        // Arrange
        final mockData = {'top_gainers': [], 'top_losers': []};
        when(
          () => mockClient.query<dynamic>(
            function: 'TOP_GAINERS_LOSERS',
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        await service.getGainersLosersActive(entitlement: 'realtime');

        // Assert
        verify(
          () => mockClient.query<dynamic>(
            function: 'TOP_GAINERS_LOSERS',
            parameters: any(named: 'parameters'),
          ),
        ).called(1);
      });
    });

    group('getCompanyOverview', () {
      test('calls query with OVERVIEW function and symbol', () async {
        // Arrange
        final mockData = {
          'Symbol': 'GOOGL',
          'Name': 'Alphabet Inc',
          'Description': 'Alphabet is a tech company...',
          'Sector': 'Technology',
        };
        when(
          () => mockClient.query<dynamic>(
            function: 'OVERVIEW',
            parameters: {'symbol': 'GOOGL'},
          ),
        ).thenAnswer((_) async => mockResponse(mockData));

        // Act
        final response = await service.getCompanyOverview('GOOGL');

        // Assert
        expect(response.statusCode, 200);
        expect(response.data['Symbol'], 'GOOGL');
        expect(response.data['Name'], 'Alphabet Inc');
        verify(
          () => mockClient.query<dynamic>(
            function: 'OVERVIEW',
            parameters: {'symbol': 'GOOGL'},
          ),
        ).called(1);
      });
    });

    group('batchQuotes', () {
      test('fetches quotes for multiple symbols sequentially', () async {
        // Arrange
        final symbols = ['AAPL', 'MSFT', 'GOOGL'];
        for (final symbol in symbols) {
          when(
            () => mockClient.query<dynamic>(
              function: 'GLOBAL_QUOTE',
              parameters: {'symbol': symbol},
            ),
          ).thenAnswer(
            (_) async => mockResponse({
              'Global Quote': {'01. symbol': symbol},
            }),
          );
        }

        // Act
        final responses = await service.batchQuotes(symbols);

        // Assert
        expect(responses.length, 3);
        for (int i = 0; i < symbols.length; i++) {
          expect(responses[i].data['Global Quote']['01. symbol'], symbols[i]);
        }
        for (final symbol in symbols) {
          verify(
            () => mockClient.query<dynamic>(
              function: 'GLOBAL_QUOTE',
              parameters: {'symbol': symbol},
            ),
          ).called(1);
        }
      });

      test('returns empty list for empty symbols', () async {
        // Act
        final responses = await service.batchQuotes([]);

        // Assert
        expect(responses, isEmpty);
        verifyNever(
          () => mockClient.query<dynamic>(
            function: any(named: 'function'),
            parameters: any(named: 'parameters'),
          ),
        );
      });
    });
  });
}
