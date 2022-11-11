import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import 'recommendation_movies_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late RecommendationMoviesBloc recommendationMoviesBloc;

  int id = 1;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMoviesBloc = RecommendationMoviesBloc(
      getMovieRecommendations: mockGetMovieRecommendations,
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

  blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
    'Should emit [Loading, Loaded] when data recommendation movies is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(id)).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return recommendationMoviesBloc;
    },
    act: (bloc) => bloc.add(const RecommendationMoviesStarted(id: 1)),
    expect: () => [
      RecommendationMoviesLoading(),
      RecommendationMoviesLoaded(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(id));
    },
  );

  blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
    'Should emit [Loading, Error] when data recommendation movies is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(id)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return recommendationMoviesBloc;
    },
    act: (bloc) => bloc.add(const RecommendationMoviesStarted(id: 1)),
    expect: () => [
      RecommendationMoviesLoading(),
      const RecommendationMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(id));
    },
  );
}
