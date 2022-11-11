import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(
      getPopularTv: mockGetPopularTv,
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

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Loaded] when data popular tv is gotten successfully',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(PopularTvStarted()),
    expect: () => [
      PopularTvLoading(),
      PopularTvLoaded(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Error] when data popular tv is unsuccessful',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(PopularTvStarted()),
    expect: () => [
      PopularTvLoading(),
      const PopularTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );
}
