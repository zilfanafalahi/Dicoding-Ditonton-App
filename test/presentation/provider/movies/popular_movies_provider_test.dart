import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_popular_movies.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/popular_movies_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_provider_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesProvider notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularMovies = MockGetPopularMovies();
    notifier = PopularMoviesProvider(mockGetPopularMovies)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  const tMovie = Movies(
    id: 1,
    backdropPath: "/backdrop_path.jpg",
    posterPath: "/poster_path.jpg",
    title: "Title",
    voteAverage: 8.5,
    releaseDate: "2022-10-25",
  );

  final tMovieList = <Movies>[tMovie];

  test('should change state to loading when usecase is called', () async {
    when(mockGetPopularMovies.execute()).thenAnswer(
      (_) async => Right(tMovieList),
    );

    notifier.fetchPopularMovies();

    expect(notifier.state, ResultState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    when(mockGetPopularMovies.execute()).thenAnswer(
      (_) async => Right(tMovieList),
    );

    await notifier.fetchPopularMovies();

    expect(notifier.state, ResultState.loaded);
    expect(notifier.movies, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetPopularMovies.execute()).thenAnswer(
      (_) async => const Left(
        ServerFailure('Server Failure'),
      ),
    );

    await notifier.fetchPopularMovies();

    expect(notifier.state, ResultState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
