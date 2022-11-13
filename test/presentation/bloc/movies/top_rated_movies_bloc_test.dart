import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesBloc topRatedMoviesBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesBloc = TopRatedMoviesBloc(
      getTopRatedMovies: mockGetTopRatedMovies,
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

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'Should emit [Loading, Loaded] when data top rated movies is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(TopRatedMoviesStarted()),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesLoaded(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'Should emit [Loading, Error] when data top rated movies is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return topRatedMoviesBloc;
    },
    act: (bloc) => bloc.add(TopRatedMoviesStarted()),
    expect: () => [
      TopRatedMoviesLoading(),
      const TopRatedMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
