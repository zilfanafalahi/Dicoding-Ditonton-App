import 'package:dicoding_ditonton_app/domain/usecases/movies/get_watchlist_status_movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  late GetWatchListStatusMovie usecase;
  late MockMoviesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMoviesRepository();
    usecase = GetWatchListStatusMovie(mockMovieRepository);
  });

  test('should get watchlist status from repository', () async {
    when(mockMovieRepository.isAddedToWatchlistMovie(1)).thenAnswer(
      (_) async => true,
    );

    final result = await usecase.execute(1);

    expect(result, true);
  });
}
