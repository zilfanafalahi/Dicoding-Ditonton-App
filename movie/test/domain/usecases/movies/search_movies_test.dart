import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMoviesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMoviesRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  final tMovies = <Movies>[];
  String query = 'Avengers';

  test('should get list of search movies from the repository', () async {
    when(mockMovieRepository.searchMovies(query)).thenAnswer(
      (_) async => Right(tMovies),
    );

    final result = await usecase.execute(query);

    expect(result, Right(tMovies));
  });
}
