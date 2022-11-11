import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
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

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Should emit [Loading, Loaded] when data now playing movies is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingMoviesStarted()),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesLoaded(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
    'Should emit [Loading, Error] when data now playing movies is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(NowPlayingMoviesStarted()),
    expect: () => [
      NowPlayingMoviesLoading(),
      const NowPlayingMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
