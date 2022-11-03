import 'dart:convert';

import 'package:dicoding_ditonton_app/common/exception.dart';
import 'package:dicoding_ditonton_app/data/datasources/movies/movies_remote_data_source.dart';
import 'package:dicoding_ditonton_app/data/models/movies/movie_detail_response.dart';
import 'package:dicoding_ditonton_app/data/models/movies/movies_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../json_reader.dart';
import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late MoviesRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = MoviesRemoteDataSourceImpl(ioClient: mockIOClient);
  });

  group('Get Now Playing Movies', () {
    final tMovieList = MoviesResponse.fromJson(
      json.decode(
        readJson('dummy_data/movies/movies_now_playing.json'),
      ),
    ).results;

    test('should return list of Movie Model when the response code is 200',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/movies/movies_now_playing.json'),
          200,
        ),
      );

      final result = await dataSource.getNowPlayingMovies();

      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.getNowPlayingMovies();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular Movies', () {
    final tMovieList = MoviesResponse.fromJson(
      json.decode(
        readJson('dummy_data/movies/movies_popular.json'),
      ),
    ).results;

    test('should return list of movies when response is success (200)',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/movies/movies_popular.json'),
          200,
        ),
      );

      final result = await dataSource.getPopularMovies();

      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.getPopularMovies();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated Movies', () {
    final tMovieList = MoviesResponse.fromJson(
      json.decode(
        readJson('dummy_data/movies/movies_top_rated_playing.json'),
      ),
    ).results;

    test('should return list of movies when response code is 200 ', () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/movies/movies_top_rated_playing.json'),
          200,
        ),
      );

      final result = await dataSource.getTopRatedMovies();

      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.getTopRatedMovies();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Movie Detail', () {
    int id = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
      json.decode(
        readJson('dummy_data/movies/movie_detail_response.json'),
      ),
    );

    test('should return movie detail when the response code is 200', () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/$id?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/movies/movie_detail_response.json'),
          200,
        ),
      );

      final result = await dataSource.getMovieDetail(id);

      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/$id?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.getMovieDetail(id);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = MoviesResponse.fromJson(
      json.decode(
        readJson(
          'dummy_data/movies/movies_recommendations_response.json',
        ),
      ),
    ).results;

    int id = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/movies/movies_recommendations_response.json'),
          200,
        ),
      );

      final result = await dataSource.getMovieRecommendations(id);

      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.getMovieRecommendations(id);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Search Movies', () {
    final tSearchResult = MoviesResponse.fromJson(
      json.decode(
        readJson(
          'dummy_data/movies/search_avengers_movie.json',
        ),
      ),
    ).results;

    String query = 'Avengers';

    test('should return list of movies when response code is 200', () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$query')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/movies/search_avengers_movie.json'),
          200,
        ),
      );

      final result = await dataSource.searchMovies(query);

      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$query')))
          .thenAnswer(
        (_) async => http.Response(
          'Not Found',
          404,
        ),
      );

      final call = dataSource.searchMovies(query);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
