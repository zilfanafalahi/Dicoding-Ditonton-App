import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  late GetMovieRecommendations usecase;
  late MockMoviesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMoviesRepository();
    usecase = GetMovieRecommendations(mockMovieRepository);
  });

  int id = 1;
  final tMovies = <Movies>[];

  test('should get list of movie recommendations from the repository',
      () async {
    when(mockMovieRepository.getMovieRecommendations(id)).thenAnswer(
      (_) async => Right(tMovies),
    );

    final result = await usecase.execute(id);

    expect(result, Right(tMovies));
  });
}
