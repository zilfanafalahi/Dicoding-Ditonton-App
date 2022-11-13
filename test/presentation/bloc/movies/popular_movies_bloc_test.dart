import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_popular_movies.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/popular_movies/popular_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesBloc popularMoviesBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(
      getPopularMovies: mockGetPopularMovies,
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

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Should emit [Loading, Loaded] when data popular movies is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(PopularMoviesStarted()),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesLoaded(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Should emit [Loading, Error] when data popular movies is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(PopularMoviesStarted()),
    expect: () => [
      PopularMoviesLoading(),
      const PopularMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
