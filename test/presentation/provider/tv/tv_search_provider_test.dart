import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/search_tv.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/tv_search_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_provider_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late TvSearchProvider provider;
  late MockSearchTv mockSearchTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTv = MockSearchTv();
    provider = TvSearchProvider(searchTv: mockSearchTv)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tTv = Tv(
    id: 37854,
    backdropPath: "/mBxsapX4DNhH1XkOlLp15He5sxL.jpg",
    posterPath: "/e3NBGiAifW9Xt8xD5tpARskjccO.jpg",
    name: "One Piece",
    voteAverage: 8.7,
    firstAirDate: "1999-10-20",
  );

  final tTvList = <Tv>[tTv];
  String query = 'One Piece';

  group('Search Tv', () {
    test('should change state to loading when usecase is called', () async {
      when(mockSearchTv.execute(query)).thenAnswer(
        (_) async => Right(tTvList),
      );

      provider.fetchTvSearch(query);

      expect(provider.state, ResultState.loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      when(mockSearchTv.execute(query)).thenAnswer(
        (_) async => Right(tTvList),
      );

      await provider.fetchTvSearch(query);

      expect(provider.state, ResultState.loaded);
      expect(provider.searchResultTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockSearchTv.execute(query)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );

      await provider.fetchTvSearch(query);

      expect(provider.state, ResultState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
