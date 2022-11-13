import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
