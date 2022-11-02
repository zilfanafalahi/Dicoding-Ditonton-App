import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/search_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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
