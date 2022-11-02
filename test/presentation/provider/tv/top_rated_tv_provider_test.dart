import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/top_rated_tv_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_provider_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvProvider notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTv = MockGetTopRatedTv();
    notifier = TopRatedTvProvider(getTopRatedTv: mockGetTopRatedTv)
      ..addListener(() {
        listenerCallCount++;
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

  test('should change state to loading when usecase is called', () async {
    when(mockGetTopRatedTv.execute()).thenAnswer(
      (_) async => Right(tTvList),
    );

    notifier.fetchTopRatedTv();

    expect(notifier.state, ResultState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv data when data is gotten successfully', () async {
    when(mockGetTopRatedTv.execute()).thenAnswer(
      (_) async => Right(tTvList),
    );

    await notifier.fetchTopRatedTv();

    expect(notifier.state, ResultState.loaded);
    expect(notifier.tv, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetTopRatedTv.execute()).thenAnswer(
      (_) async => const Left(
        ServerFailure('Server Failure'),
      ),
    );

    await notifier.fetchTopRatedTv();

    expect(notifier.state, ResultState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
