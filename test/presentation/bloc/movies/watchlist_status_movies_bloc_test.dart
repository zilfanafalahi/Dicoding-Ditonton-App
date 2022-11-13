import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_watchlist_status_movie.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/remove_watchlist_movie.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/save_watchlist_movie.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/watchlist_status_movies/watchlist_status_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movies/dummy_objects_movies.dart';
import 'watchlist_status_movies_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatusMovie,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
])
void main() {
  late MockGetWatchListStatusMovie mockGetWatchListStatusMovie;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;
  late WatchlistStatusMoviesBloc watchlistStatusMoviesBloc;

  int id = 1;

  setUp(() {
    mockGetWatchListStatusMovie = MockGetWatchListStatusMovie();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    watchlistStatusMoviesBloc = WatchlistStatusMoviesBloc(
      getWatchListStatusMovie: mockGetWatchListStatusMovie,
      saveWatchlistMovie: mockSaveWatchlistMovie,
      removeWatchlistMovie: mockRemoveWatchlistMovie,
    );
  });

  blocTest<WatchlistStatusMoviesBloc, WatchlistStatusMoviesState>(
    'Should emit [Loaded] when data watchlist status movies is gotten successfully',
    build: () {
      when(mockGetWatchListStatusMovie.execute(id)).thenAnswer(
        (_) async => true,
      );
      return watchlistStatusMoviesBloc;
    },
    act: (bloc) => bloc.add(const WatchlistStatusMovieStarted(id: 1)),
    expect: () => [
      const IsSaveWatchlistStatusMovies(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatusMovie.execute(id));
    },
  );

  blocTest<WatchlistStatusMoviesBloc, WatchlistStatusMoviesState>(
    'Should emit [Success] when data add movie to watchlist is gotten successfully',
    build: () {
      when(mockSaveWatchlistMovie.execute(testMoviesDetail)).thenAnswer(
        (_) async => const Right('Added to Watchlist'),
      );
      when(mockGetWatchListStatusMovie.execute(id)).thenAnswer(
        (_) async => true,
      );
      return watchlistStatusMoviesBloc;
    },
    act: (bloc) {
      bloc.add(const SaveWatchlistStatusMoviesStarted(
        detailMovies: testMoviesDetail,
      ));
      bloc.add(const WatchlistStatusMovieStarted(id: 1));
    },
    expect: () => [
      const SaveWatchlistStatusMoviesMessage('Added to Watchlist'),
      const IsSaveWatchlistStatusMovies(true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistMovie.execute(testMoviesDetail));
      verify(mockGetWatchListStatusMovie.execute(id));
    },
  );

  blocTest<WatchlistStatusMoviesBloc, WatchlistStatusMoviesState>(
    'Should emit [Success] when data remove movie from watchlist is gotten successfully',
    build: () {
      when(mockRemoveWatchlistMovie.execute(testMoviesDetail)).thenAnswer(
        (_) async => const Right('Removed from Watchlist'),
      );
      when(mockGetWatchListStatusMovie.execute(id)).thenAnswer(
        (_) async => false,
      );
      return watchlistStatusMoviesBloc;
    },
    act: (bloc) {
      bloc.add(const RemoveWatchlistStatusMoviesStarted(
        detailMovies: testMoviesDetail,
      ));
      bloc.add(const WatchlistStatusMovieStarted(id: 1));
    },
    expect: () => [
      const RemoveWatchlistStatusMoviesMessage('Removed from Watchlist'),
      const IsSaveWatchlistStatusMovies(false),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistMovie.execute(testMoviesDetail));
      verify(mockGetWatchListStatusMovie.execute(id));
    },
  );
}
