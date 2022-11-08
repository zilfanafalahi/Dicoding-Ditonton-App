import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_popular_tv.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/popular_tv_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_provider_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvProvider notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTv = MockGetPopularTv();
    notifier = PopularTvProvider(getPopularTv: mockGetPopularTv)
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
    when(mockGetPopularTv.execute()).thenAnswer(
      (_) async => Right(tTvList),
    );

    notifier.fetchPopularTv();

    expect(notifier.state, ResultState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv data when data is gotten successfully', () async {
    when(mockGetPopularTv.execute()).thenAnswer(
      (_) async => Right(tTvList),
    );

    await notifier.fetchPopularTv();

    expect(notifier.state, ResultState.loaded);
    expect(notifier.tv, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetPopularTv.execute()).thenAnswer(
      (_) async => const Left(
        ServerFailure('Server Failure'),
      ),
    );

    await notifier.fetchPopularTv();

    expect(notifier.state, ResultState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
