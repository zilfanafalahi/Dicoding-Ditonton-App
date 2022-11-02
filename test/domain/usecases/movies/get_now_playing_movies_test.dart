import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  late GetNowPlayingMovies usecase;
  late MockMoviesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMoviesRepository();
    usecase = GetNowPlayingMovies(mockMovieRepository);
  });

  final tMovies = <Movies>[];

  test('should get list of popular movies from the repository', () async {
    when(mockMovieRepository.getNowPlayingMovies()).thenAnswer(
      (_) async => Right(tMovies),
    );

    final result = await usecase.execute();

    expect(result, Right(tMovies));
  });
}
