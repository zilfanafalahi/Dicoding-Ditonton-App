import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_popular_movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/movies_list_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movies_list_provider_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
])
void main() {
  late MoviesListProvider provider;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    provider = MoviesListProvider(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    )..addListener(() {
        listenerCallCount += 1;
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

  group('Now Playing Movies', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(ResultState.empty));
    });

    test('should get data from the usecase', () async {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );

      provider.fetchNowPlayingMovies();

      verify(mockGetNowPlayingMovies.execute());
    });

    test('should change state to Loading when usecase is called', () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );

      provider.fetchNowPlayingMovies();

      expect(provider.nowPlayingState, ResultState.loading);
    });

    test('should change movies when data is gotten successfully', () async {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );

      await provider.fetchNowPlayingMovies();

      expect(provider.nowPlayingState, ResultState.loaded);
      expect(provider.nowPlayingMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
        (_) async => const Left(
          ServerFailure('Server Failure'),
        ),
      );

      await provider.fetchNowPlayingMovies();

      expect(provider.nowPlayingState, ResultState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Popular Movies', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetPopularMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );

      provider.fetchPopularMovies();

      expect(provider.popularMoviesState, ResultState.loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      when(mockGetPopularMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );

      await provider.fetchPopularMovies();

      expect(provider.popularMoviesState, ResultState.loaded);
      expect(provider.popularMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetPopularMovies.execute()).thenAnswer(
        (_) async => const Left(
          ServerFailure('Server Failure'),
        ),
      );

      await provider.fetchPopularMovies();

      expect(provider.popularMoviesState, ResultState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Top Rated Movies', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );

      provider.fetchTopRatedMovies();

      expect(provider.topRatedMoviesState, ResultState.loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );

      await provider.fetchTopRatedMovies();

      expect(provider.topRatedMoviesState, ResultState.loaded);
      expect(provider.topRatedMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
        (_) async => const Left(
          ServerFailure('Server Failure'),
        ),
      );

      await provider.fetchTopRatedMovies();

      expect(provider.topRatedMoviesState, ResultState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
