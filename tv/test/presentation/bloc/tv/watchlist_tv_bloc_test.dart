import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late WatchlistTvBloc watchlistTvBloc;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    watchlistTvBloc = WatchlistTvBloc(
      getWatchlistTv: mockGetWatchlistTv,
    );
  });

  const ttv = Tv(
    id: 1,
    backdropPath: "/backdrop_path.jpg",
    posterPath: "/poster_path.jpg",
    name: "Name",
    voteAverage: 8.5,
    firstAirDate: "2022-10-25",
  );

  final ttvList = <Tv>[ttv];

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, Loaded] when data watchlist tv is gotten successfully',
    build: () {
      when(mockGetWatchlistTv.execute()).thenAnswer(
        (_) async => Right(ttvList),
      );
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvStarted()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvLoaded(ttvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, Error] when data watchlist tv is unsuccessful',
    build: () {
      when(mockGetWatchlistTv.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvStarted()),
    expect: () => [
      WatchlistTvLoading(),
      const WatchlistTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );
}
