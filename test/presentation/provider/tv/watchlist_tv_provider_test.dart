import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/watchlist_tv_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import 'watchlist_tv_provider_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchlistTvProvider provider;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTv = MockGetWatchlistTv();
    provider = WatchlistTvProvider(
      getWatchlistTv: mockGetWatchlistTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change tv data when data is gotten successfully', () async {
    when(mockGetWatchlistTv.execute()).thenAnswer(
      (_) async => const Right([testWatchlistTv]),
    );

    await provider.fetchWatchlistTv();

    expect(provider.watchlistState, ResultState.loaded);
    expect(provider.watchlistTv, [testWatchlistTv]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetWatchlistTv.execute()).thenAnswer(
      (_) async => const Left(DatabaseFailure("Can't get data")),
    );

    await provider.fetchWatchlistTv();

    expect(provider.watchlistState, ResultState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
