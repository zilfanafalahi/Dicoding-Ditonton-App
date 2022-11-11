import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late DetailTvBloc detailtvBloc;

  int id = 1;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    detailtvBloc = DetailTvBloc(
      getTvDetail: mockGetTvDetail,
    );
  });

  blocTest<DetailTvBloc, DetailTvState>(
    'Should emit [Loading, Loaded] when data detail tv is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(id)).thenAnswer(
        (_) async => const Right(testTvDetail),
      );
      return detailtvBloc;
    },
    act: (bloc) => bloc.add(const DetailTvStarted(id: 1)),
    expect: () => [
      DetailTvLoading(),
      const DetailTvLoaded(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
    },
  );

  blocTest<DetailTvBloc, DetailTvState>(
    'Should emit [Loading, Error] when data detail tv is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(id)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return detailtvBloc;
    },
    act: (bloc) => bloc.add(const DetailTvStarted(id: 1)),
    expect: () => [
      DetailTvLoading(),
      const DetailTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(id));
    },
  );
}
