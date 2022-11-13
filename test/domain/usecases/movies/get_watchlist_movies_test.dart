import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movies/dummy_objects_movies.dart';
import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  late GetWatchlistMovies usecase;
  late MockMoviesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMoviesRepository();
    usecase = GetWatchlistMovies(mockMovieRepository);
  });

  test('should get list of watchlist movies from the repository', () async {
    when(mockMovieRepository.getWatchlistMovies()).thenAnswer(
      (_) async => Right(testMoviesList),
    );

    final result = await usecase.execute();

    expect(result, Right(testMoviesList));
  });
}
