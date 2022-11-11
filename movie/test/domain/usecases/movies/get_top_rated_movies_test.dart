import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

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
