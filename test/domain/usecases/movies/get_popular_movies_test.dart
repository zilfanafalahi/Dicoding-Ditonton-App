import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_popular_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  late GetPopularMovies usecase;
  late MockMoviesRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockMoviesRepository();
    usecase = GetPopularMovies(mockMovieRpository);
  });

  final tMovies = <Movies>[];

  group('GetPopularMovies Tests', () {
    group('Execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        when(mockMovieRpository.getPopularMovies()).thenAnswer(
          (_) async => Right(tMovies),
        );

        final result = await usecase.execute();

        expect(result, Right(tMovies));
      });
    });
  });
}
