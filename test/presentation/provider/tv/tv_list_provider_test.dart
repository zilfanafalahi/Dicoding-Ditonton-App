import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_on_the_air_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_popular_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/tv_list_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_provider_test.mocks.dart';

@GenerateMocks([
  GetOnTheAirTv,
  GetPopularTv,
  GetTopRatedTv,
])
void main() {
  late TvListProvider provider;
  late MockGetOnTheAirTv mockGetOnTheAirTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    provider = TvListProvider(
      getOnTheAirTv: mockGetOnTheAirTv,
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
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

  group('On The Air Tv', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirState, equals(ResultState.empty));
    });

    test('should get data from the usecase', () async {
      when(mockGetOnTheAirTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );

      provider.fetchOnTheAirTv();

      verify(mockGetOnTheAirTv.execute());
    });

    test('should change state to Loading when usecase is called', () {
      when(mockGetOnTheAirTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );

      provider.fetchOnTheAirTv();

      expect(provider.onTheAirState, ResultState.loading);
    });

    test('should change tv when data is gotten successfully', () async {
      when(mockGetOnTheAirTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );

      await provider.fetchOnTheAirTv();

      expect(provider.onTheAirState, ResultState.loaded);
      expect(provider.onTheAirTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetOnTheAirTv.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );

      await provider.fetchOnTheAirTv();

      expect(provider.onTheAirState, ResultState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Popular Tv', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetPopularTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );

      provider.fetchPopularTv();

      expect(provider.popularTvState, ResultState.loading);
    });

    test('should change tv data when data is gotten successfully', () async {
      when(mockGetPopularTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );

      await provider.fetchPopularTv();

      expect(provider.popularTvState, ResultState.loaded);
      expect(provider.popularTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetPopularTv.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );

      await provider.fetchPopularTv();

      expect(provider.popularTvState, ResultState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Top Rated Tv', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetTopRatedTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );

      provider.fetchTopRatedTv();

      expect(provider.topRatedTvState, ResultState.loading);
    });

    test('should change tv data when data is gotten successfully', () async {
      when(mockGetTopRatedTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );

      await provider.fetchTopRatedTv();

      expect(provider.topRatedTvState, ResultState.loaded);
      expect(provider.topRatedTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTopRatedTv.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );

      await provider.fetchTopRatedTv();

      expect(provider.topRatedTvState, ResultState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
