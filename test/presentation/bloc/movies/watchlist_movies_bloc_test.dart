import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMoviesBloc watchlistMoviesBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMoviesBloc = WatchlistMoviesBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
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

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [Loading, Loaded] when data watchlist movies is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(WatchlistMoviesStarted()),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesLoaded(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
    'Should emit [Loading, Error] when data watchlist movies is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return watchlistMoviesBloc;
    },
    act: (bloc) => bloc.add(WatchlistMoviesStarted()),
    expect: () => [
      WatchlistMoviesLoading(),
      const WatchlistMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
