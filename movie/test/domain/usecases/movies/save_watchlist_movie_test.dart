import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../dummy_data/movies/dummy_objects_movies.dart';
import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  late SaveWatchlistMovie usecase;
  late MockMoviesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMoviesRepository();
    usecase = SaveWatchlistMovie(mockMovieRepository);
  });

  test('should save movie to the repository', () async {
    when(mockMovieRepository.saveWatchlistMovie(testMoviesDetail)).thenAnswer(
      (_) async => const Right('Added to Watchlist'),
    );

    final result = await usecase.execute(testMoviesDetail);

    verify(mockMovieRepository.saveWatchlistMovie(testMoviesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
