import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../dummy_data/movies/dummy_objects_movies.dart';
import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  late RemoveWatchlistMovie usecase;
  late MockMoviesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMoviesRepository();
    usecase = RemoveWatchlistMovie(mockMovieRepository);
  });

  test('should remove watchlist movie from repository', () async {
    when(mockMovieRepository.removeWatchlistMovie(testMoviesDetail)).thenAnswer(
      (_) async => const Right('Removed from watchlist'),
    );

    final result = await usecase.execute(testMoviesDetail);

    verify(mockMovieRepository.removeWatchlistMovie(testMoviesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
