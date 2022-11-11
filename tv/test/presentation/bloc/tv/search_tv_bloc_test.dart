import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late MockSearchTv mockSearchTv;
  late SearchTvBloc searchTvBloc;

  String query = 'One Piece';

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchTvBloc = SearchTvBloc(
      searchTv: mockSearchTv,
    );
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

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Loaded] when data search tv is gotten successfully',
    build: () {
      when(mockSearchTv.execute(query)).thenAnswer(
        (_) async => Right(tTvList),
      );
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(const SearchTvStarted(query: 'One Piece')),
    expect: () => [
      SearchTvLoading(),
      SearchTvLoaded(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(query));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Error] when data search tv is unsuccessful',
    build: () {
      when(mockSearchTv.execute(query)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(const SearchTvStarted(query: 'One Piece')),
    expect: () => [
      SearchTvLoading(),
      const SearchTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(query));
    },
  );
}
