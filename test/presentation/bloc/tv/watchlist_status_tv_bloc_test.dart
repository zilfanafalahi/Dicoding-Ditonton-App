import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/watchlist_status_tv/watchlist_status_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import 'watchlist_status_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late WatchlistStatusTvBloc watchlistStatusTvBloc;

  int id = 1;

  setUp(() {
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    watchlistStatusTvBloc = WatchlistStatusTvBloc(
      getWatchListStatusTv: mockGetWatchListStatusTv,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
    );
  });

  blocTest<WatchlistStatusTvBloc, WatchlistStatusTvState>(
    'Should emit [Loaded] when data watchlist status tv is gotten successfully',
    build: () {
      when(mockGetWatchListStatusTv.execute(id)).thenAnswer(
        (_) async => true,
      );
      return watchlistStatusTvBloc;
    },
    act: (bloc) => bloc.add(const WatchlistStatusTvtarted(id: 1)),
    expect: () => [
      const IsSaveWatchlistStatusTv(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatusTv.execute(id));
    },
  );

  blocTest<WatchlistStatusTvBloc, WatchlistStatusTvState>(
    'Should emit [Success] when data add tv to watchlist is gotten successfully',
    build: () {
      when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer(
        (_) async => const Right('Added to Watchlist'),
      );
      when(mockGetWatchListStatusTv.execute(id)).thenAnswer(
        (_) async => true,
      );
      return watchlistStatusTvBloc;
    },
    act: (bloc) {
      bloc.add(const SaveWatchlistStatusTvStarted(
        detailTv: testTvDetail,
      ));
      bloc.add(const WatchlistStatusTvtarted(id: 1));
    },
    expect: () => [
      const SaveWatchlistStatusTvMessage('Added to Watchlist'),
      const IsSaveWatchlistStatusTv(true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistTv.execute(testTvDetail));
      verify(mockGetWatchListStatusTv.execute(id));
    },
  );

  blocTest<WatchlistStatusTvBloc, WatchlistStatusTvState>(
    'Should emit [Success] when data remove tv from watchlist is gotten successfully',
    build: () {
      when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer(
        (_) async => const Right('Removed from Watchlist'),
      );
      when(mockGetWatchListStatusTv.execute(id)).thenAnswer(
        (_) async => false,
      );
      return watchlistStatusTvBloc;
    },
    act: (bloc) {
      bloc.add(const RemoveWatchlistStatusTvStarted(
        detailTv: testTvDetail,
      ));
      bloc.add(const WatchlistStatusTvtarted(id: 1));
    },
    expect: () => [
      const RemoveWatchlistStatusTvMessage('Removed from Watchlist'),
      const IsSaveWatchlistStatusTv(false),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
      verify(mockGetWatchListStatusTv.execute(id));
    },
  );
}
