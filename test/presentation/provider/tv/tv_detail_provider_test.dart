import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/tv_detail_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import 'tv_detail_provider_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailProvider provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatusTv mockGetWatchlistStatus;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatusTv();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    provider = TvDetailProvider(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatusTv: mockGetWatchlistStatus,
      saveWatchlistTv: mockSaveWatchlist,
      removeWatchlistTv: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  int id = 1;

  const tTv = Tv(
    id: 1,
    backdropPath: "/backdrop_path.jpg",
    posterPath: "/poster_path.jpg",
    name: "Name",
    voteAverage: 8.5,
    firstAirDate: "2022-10-25",
  );

  final tTvList = <Tv>[tTv];

  void arrangeUsecase() {
    when(mockGetTvDetail.execute(id))
        .thenAnswer((_) async => const Right(testTvDetail));
    when(mockGetTvRecommendations.execute(id))
        .thenAnswer((_) async => Right(tTvList));
  }

  group('Get Tv Detail', () {
    test('should get data from the usecase', () async {
      arrangeUsecase();

      await provider.fetchTvDetail(id);

      verify(mockGetTvDetail.execute(id));
      verify(mockGetTvRecommendations.execute(id));
    });

    test('should change state to Loading when usecase is called', () {
      arrangeUsecase();

      provider.fetchTvDetail(id);

      expect(provider.tvState, ResultState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      arrangeUsecase();

      await provider.fetchTvDetail(id);

      expect(provider.tvState, ResultState.loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tv when data is gotten successfully',
        () async {
      arrangeUsecase();

      await provider.fetchTvDetail(id);

      expect(provider.tvState, ResultState.loaded);
      expect(provider.tvRecommendations, tTvList);
    });
  });

  group('Get Tv Recommendations', () {
    test('should get data from the usecase', () async {
      arrangeUsecase();

      await provider.fetchTvDetail(id);

      verify(mockGetTvRecommendations.execute(id));
      expect(provider.tvRecommendations, tTvList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      arrangeUsecase();

      await provider.fetchTvDetail(id);

      expect(provider.tvRecommendationState, ResultState.loaded);
      expect(provider.tvRecommendations, tTvList);
    });

    test('should update error message when request in successful', () async {
      when(mockGetTvDetail.execute(id)).thenAnswer(
        (_) async => const Right(testTvDetail),
      );
      when(mockGetTvRecommendations.execute(id)).thenAnswer(
        (_) async => const Left(
          ServerFailure('Failed'),
        ),
      );

      await provider.fetchTvDetail(id);

      expect(provider.tvRecommendationState, ResultState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);

      await provider.loadWatchlistStatusTv(1);

      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      when(mockSaveWatchlist.execute(testTvDetail)).thenAnswer(
        (_) async => const Right('Success'),
      );
      when(mockGetWatchlistStatus.execute(testTvDetail.id)).thenAnswer(
        (_) async => true,
      );

      await provider.addWatchlistTv(testTvDetail);

      verify(mockSaveWatchlist.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      when(mockRemoveWatchlist.execute(testTvDetail)).thenAnswer(
        (_) async => const Right('Removed'),
      );
      when(mockGetWatchlistStatus.execute(testTvDetail.id)).thenAnswer(
        (_) async => false,
      );

      await provider.removeFromWatchlistTv(testTvDetail);

      verify(mockRemoveWatchlist.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      when(mockSaveWatchlist.execute(testTvDetail)).thenAnswer(
        (_) async => const Right('Added to Watchlist'),
      );
      when(mockGetWatchlistStatus.execute(testTvDetail.id)).thenAnswer(
        (_) async => true,
      );

      await provider.addWatchlistTv(testTvDetail);

      verify(mockGetWatchlistStatus.execute(testTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      when(mockSaveWatchlist.execute(testTvDetail)).thenAnswer(
        (_) async => const Left(DatabaseFailure('Failed')),
      );
      when(mockGetWatchlistStatus.execute(testTvDetail.id)).thenAnswer(
        (_) async => false,
      );

      await provider.addWatchlistTv(testTvDetail);

      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('On Error', () {
    test('should return error when data is unsuccessful', () async {
      when(mockGetTvDetail.execute(id)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      when(mockGetTvRecommendations.execute(id)).thenAnswer(
        (_) async => Right(tTvList),
      );

      await provider.fetchTvDetail(id);

      expect(provider.tvState, ResultState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
