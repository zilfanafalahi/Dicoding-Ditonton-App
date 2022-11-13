import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_season_detail.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/season_detail_tv/season_detail_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import 'season_detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeasonDetail])
void main() {
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;
  late SeasonDetailTvBloc seasonDetailTvBloc;

  int id = 1;
  int seasonNumber = 1;

  setUp(() {
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();
    seasonDetailTvBloc = SeasonDetailTvBloc(
      getTvSeasonDetail: mockGetTvSeasonDetail,
    );
  });

  blocTest<SeasonDetailTvBloc, SeasonDetailTvState>(
    'Should emit [Loading, Loaded] when data season detail tv is gotten successfully',
    build: () {
      when(mockGetTvSeasonDetail.execute(id, seasonNumber)).thenAnswer(
        (_) async => const Right(testTvSeasonDetail),
      );
      return seasonDetailTvBloc;
    },
    act: (bloc) => bloc.add(const SeasonDetailTvStarted(
      id: 1,
      seasonNumber: 1,
    )),
    expect: () => [
      SeasonDetailTvLoading(),
      const SeasonDetailTvLoaded(testTvSeasonDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvSeasonDetail.execute(id, seasonNumber));
    },
  );

  blocTest<SeasonDetailTvBloc, SeasonDetailTvState>(
    'Should emit [Loading, Error] when data season detail tv is unsuccessful',
    build: () {
      when(mockGetTvSeasonDetail.execute(id, seasonNumber)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return seasonDetailTvBloc;
    },
    act: (bloc) => bloc.add(const SeasonDetailTvStarted(
      id: 1,
      seasonNumber: 1,
    )),
    expect: () => [
      SeasonDetailTvLoading(),
      const SeasonDetailTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeasonDetail.execute(id, seasonNumber));
    },
  );
}
