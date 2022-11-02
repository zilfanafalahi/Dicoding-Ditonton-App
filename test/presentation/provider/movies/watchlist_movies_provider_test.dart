import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/watchlist_movies_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movies/dummy_objects_movies.dart';
import 'watchlist_movies_provider_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMoviesProvider provider;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    provider = WatchlistMoviesProvider(
      getWatchlistMovies: mockGetWatchlistMovies,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    when(mockGetWatchlistMovies.execute()).thenAnswer(
      (_) async => const Right([testWatchlistMovies]),
    );

    await provider.fetchWatchlistMovies();

    expect(provider.watchlistState, ResultState.loaded);
    expect(provider.watchlistMovies, [testWatchlistMovies]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetWatchlistMovies.execute()).thenAnswer(
      (_) async => const Left(
        DatabaseFailure("Can't get data"),
      ),
    );

    await provider.fetchWatchlistMovies();

    expect(provider.watchlistState, ResultState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
