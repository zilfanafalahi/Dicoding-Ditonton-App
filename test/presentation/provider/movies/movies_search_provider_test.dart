import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/search_movies.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/movies_search_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movies_search_provider_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MoviesSearchProvider provider;
  late MockSearchMovies mockSearchMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchMovies();
    provider = MoviesSearchProvider(searchMovies: mockSearchMovies)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tMovieModel = Movies(
    id: 24428,
    posterPath: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
    backdropPath: "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg",
    title: "The Avengers",
    voteAverage: 7.33,
    releaseDate: "2012-04-25",
  );
  final tMovieList = <Movies>[tMovieModel];
  String query = 'Avengers';

  group('Search Movies', () {
    test('should change state to loading when usecase is called', () async {
      when(mockSearchMovies.execute(query)).thenAnswer(
        (_) async => Right(tMovieList),
      );

      provider.fetchMovieSearch(query);

      expect(provider.state, ResultState.loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      when(mockSearchMovies.execute(query)).thenAnswer(
        (_) async => Right(tMovieList),
      );

      await provider.fetchMovieSearch(query);

      expect(provider.state, ResultState.loaded);
      expect(provider.searchResultMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockSearchMovies.execute(query)).thenAnswer(
        (_) async => const Left(
          ServerFailure('Server Failure'),
        ),
      );

      await provider.fetchMovieSearch(query);

      expect(provider.state, ResultState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
