import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late MockGetTvRecommendations mockGetTvRecommendations;
  late RecommendationTvBloc recommendationTvBloc;

  int id = 1;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    recommendationTvBloc = RecommendationTvBloc(
      getTvRecommendations: mockGetTvRecommendations,
    );
  });

  const tTv = Tv(
    id: 1,
    backdropPath: "/backdrop_path.jpg",
    posterPath: "/poster_path.jpg",
    name: "Name",
    voteAverage: 8.5,
    firstAirDate: "2022-10-25",
  );

  final tTvList = <Tv>[tTv];

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, Loaded] when data recommendation tv is gotten successfully',
    build: () {
      when(mockGetTvRecommendations.execute(id)).thenAnswer(
        (_) async => Right(tTvList),
      );
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(const RecommendationTvStarted(id: 1)),
    expect: () => [
      RecommendationTvLoading(),
      RecommendationTvLoaded(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(id));
    },
  );

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [Loading, Error] when data recommendation tv is unsuccessful',
    build: () {
      when(mockGetTvRecommendations.execute(id)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(const RecommendationTvStarted(id: 1)),
    expect: () => [
      RecommendationTvLoading(),
      const RecommendationTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(id));
    },
  );
}
