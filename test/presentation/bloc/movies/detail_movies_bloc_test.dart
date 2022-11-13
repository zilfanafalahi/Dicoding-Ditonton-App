import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_movie_detail.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/detail_movies/detail_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movies/dummy_objects_movies.dart';
import 'detail_movies_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late DetailMoviesBloc detailMoviesBloc;

  int id = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMoviesBloc = DetailMoviesBloc(
      getMovieDetail: mockGetMovieDetail,
    );
  });

  blocTest<DetailMoviesBloc, DetailMoviesState>(
    'Should emit [Loading, Loaded] when data detail movies is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(id)).thenAnswer(
        (_) async => const Right(testMoviesDetail),
      );
      return detailMoviesBloc;
    },
    act: (bloc) => bloc.add(const DetailMoviesStarted(id: 1)),
    expect: () => [
      DetailMoviesLoading(),
      const DetailMoviesLoaded(testMoviesDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id));
    },
  );

  blocTest<DetailMoviesBloc, DetailMoviesState>(
    'Should emit [Loading, Error] when data detail movies is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(id)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return detailMoviesBloc;
    },
    act: (bloc) => bloc.add(const DetailMoviesStarted(id: 1)),
    expect: () => [
      DetailMoviesLoading(),
      const DetailMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id));
    },
  );
}
