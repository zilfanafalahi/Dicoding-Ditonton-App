import 'dart:convert';
import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../json_reader.dart';
import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = TvRemoteDataSourceImpl(ioClient: mockIOClient);
  });

  group('Get On The Air Tv', () {
    final tTvList = TvResponse.fromJson(
      json.decode(
        readJson('dummy_data/tv/tv_on_the_air.json'),
      ),
    ).results;

    test('should return list of Tv Model when the response code is 200',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv/tv_on_the_air.json'),
          200,
        ),
      );

      final result = await dataSource.getOnTheAirTv();

      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.getOnTheAirTv();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular Tv', () {
    final tTvList = TvResponse.fromJson(
      json.decode(
        readJson('dummy_data/tv/tv_popular.json'),
      ),
    ).results;

    test('should return list of movies when response is success (200)',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv/tv_popular.json'),
          200,
        ),
      );

      final result = await dataSource.getPopularTv();

      expect(result, tTvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.getPopularTv();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated Tv', () {
    final tTvList = TvResponse.fromJson(json.decode(
      readJson(
        'dummy_data/tv/tv_top_rated_playing.json',
      ),
    )).results;

    test('should return list of movies when response code is 200 ', () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv/tv_top_rated_playing.json'),
          200,
        ),
      );

      final result = await dataSource.getTopRatedTv();

      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.getTopRatedTv();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Detail', () {
    int id = 1;
    final tTvDetail = TvDetailResponse.fromJson(
      json.decode(
        readJson(
          'dummy_data/tv/tv_detail_response.json',
        ),
      ),
    );

    test('should return tv detail when the response code is 200', () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/$id?$apiKey'))).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv/tv_detail_response.json'),
          200,
        ),
      );

      final result = await dataSource.getTvDetail(id);

      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/$id?$apiKey'))).thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.getTvDetail(id);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Recommendations', () {
    final tTvList = TvResponse.fromJson(
      json.decode(
        readJson(
          'dummy_data/tv/tv_recommendations_response.json',
        ),
      ),
    ).results;

    int id = 1;

    test('should return list of Tv Model when the response code is 200',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv/tv_recommendations_response.json'),
          200,
        ),
      );

      final result = await dataSource.getTvRecommendations(id);

      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.getTvRecommendations(id);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Search Tv', () {
    final tSearchResult = TvResponse.fromJson(
      json.decode(
        readJson(
          'dummy_data/tv/search_one_piece_tv.json',
        ),
      ),
    ).results;

    String query = 'One Piece';

    test('should return list of tv when response code is 200', () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv/search_one_piece_tv.json'),
          200,
        ),
      );

      final result = await dataSource.searchTv(query);

      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.searchTv(query);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Season Detail', () {
    final tTvSeason = TvSeasonDetailResponse.fromJson(
      json.decode(
        readJson(
          'dummy_data/tv/tv_season_detail_response.json',
        ),
      ),
    );

    int id = 1;
    int seasonNumber = 1;

    test('should return list of Tv Model when the response code is 200',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$id/season/$seasonNumber?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv/tv_season_detail_response.json'),
          200,
        ),
      );

      final result = await dataSource.getTvSeasonDetail(id, seasonNumber);

      expect(result, equals(tTvSeason));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$id/season/$seasonNumber?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.getTvSeasonDetail(id, seasonNumber);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
