import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/search_movies.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/search_movies/search_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_movies_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mockSearchMovies;
  late SearchMoviesBloc searchMoviesBloc;

  String query = 'Avengers';

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviesBloc = SearchMoviesBloc(
      searchMovies: mockSearchMovies,
    );
  });

  const tMovie = Movies(
    id: 24428,
    posterPath: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
    backdropPath: "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg",
    title: "The Avengers",
    voteAverage: 7.33,
    releaseDate: "2012-04-25",
  );

  final tMovieList = <Movies>[tMovie];

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'Should emit [Loading, Loaded] when data search movies is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(query)).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(const SearchMoviesStarted(query: 'Avengers')),
    expect: () => [
      SearchMoviesLoading(),
      SearchMoviesLoaded(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'Should emit [Loading, Error] when data search movies is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(query)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(const SearchMoviesStarted(query: 'Avengers')),
    expect: () => [
      SearchMoviesLoading(),
      const SearchMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );
}
