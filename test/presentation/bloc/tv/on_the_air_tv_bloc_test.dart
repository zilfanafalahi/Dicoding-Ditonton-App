import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_on_the_air_tv.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/on_the_air_tv/on_the_air_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_the_air_tv_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTv])
void main() {
  late MockGetOnTheAirTv mockGetOnTheAirTv;
  late OnTheAirTvBloc onTheAirTvBloc;

  setUp(() {
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    onTheAirTvBloc = OnTheAirTvBloc(
      getOnTheAirTv: mockGetOnTheAirTv,
    );
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

  blocTest<OnTheAirTvBloc, OnTheAirTvState>(
    'Should emit [Loading, Loaded] when data on the air tv is gotten successfully',
    build: () {
      when(mockGetOnTheAirTv.execute()).thenAnswer(
        (_) async => Right(tTvList),
      );
      return onTheAirTvBloc;
    },
    act: (bloc) => bloc.add(OnTheAirTvStarted()),
    expect: () => [
      OnTheAirTvLoading(),
      OnTheAirTvLoaded(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTv.execute());
    },
  );

  blocTest<OnTheAirTvBloc, OnTheAirTvState>(
    'Should emit [Loading, Error] when data on the air tv is unsuccessful',
    build: () {
      when(mockGetOnTheAirTv.execute()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return onTheAirTvBloc;
    },
    act: (bloc) => bloc.add(OnTheAirTvStarted()),
    expect: () => [
      OnTheAirTvLoading(),
      const OnTheAirTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTv.execute());
    },
  );
}
