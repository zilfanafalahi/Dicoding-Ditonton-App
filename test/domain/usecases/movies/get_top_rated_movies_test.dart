import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  late GetTopRatedMovies usecase;
  late MockMoviesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMoviesRepository();
    usecase = GetTopRatedMovies(mockMovieRepository);
  });

  final tMovies = <Movies>[];

  test('should get list of movies from repository', () async {
    when(mockMovieRepository.getTopRatedMovies()).thenAnswer(
      (_) async => Right(tMovies),
    );

    final result = await usecase.execute();

    expect(result, Right(tMovies));
  });
}
