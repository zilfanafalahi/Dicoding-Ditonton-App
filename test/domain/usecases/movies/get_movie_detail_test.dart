import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movies/dummy_objects_movies.dart';
import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  late GetMovieDetail usecase;
  late MockMoviesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMoviesRepository();
    usecase = GetMovieDetail(mockMovieRepository);
  });

  int id = 1;

  test('should get movie detail from the repository', () async {
    when(mockMovieRepository.getMovieDetail(id)).thenAnswer(
      (_) async => const Right(
        testMoviesDetail,
      ),
    );

    final result = await usecase.execute(id);

    expect(result, const Right(testMoviesDetail));
  });
}
