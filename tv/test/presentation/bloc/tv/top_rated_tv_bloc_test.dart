import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvBloc topRatedTvBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(
      getTopRatedTv: mockGetTopRatedTv,
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

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Loaded] when data top rated tv is gotten successfully',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(TopRatedTvStarted()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvLoaded(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Error] when data top rated tv is unsuccessful',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(TopRatedTvStarted()),
    expect: () => [
      TopRatedTvLoading(),
      const TopRatedTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );
}
