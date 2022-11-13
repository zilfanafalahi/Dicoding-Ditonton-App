import 'package:dicoding_ditonton_app/common/exception.dart';
import 'package:dicoding_ditonton_app/data/datasources/movies/movies_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movies/dummy_objects_movies.dart';
import '../../../helpers/test_helper_movies.mocks.dart';

void main() {
  late MoviesLocalDataSourceImpl dataSource;
  late MockDbHelper mockDbHelper;

  setUp(() {
    mockDbHelper = MockDbHelper();
    dataSource = MoviesLocalDataSourceImpl(dbHelper: mockDbHelper);
  });

  group('Save Watchlist Movie', () {
    test('should return success message when insert to database is success',
        () async {
      when(mockDbHelper.insertWatchlistMovie(testMoviesTable)).thenAnswer(
        (_) async => 1,
      );

      final result = await dataSource.insertWatchlistMovie(testMoviesTable);

      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      when(mockDbHelper.insertWatchlistMovie(testMoviesTable)).thenThrow(
        Exception(),
      );

      final call = dataSource.insertWatchlistMovie(testMoviesTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Watchlist Movie', () {
    test('should return success message when remove from database is success',
        () async {
      when(mockDbHelper.removeWatchlistMovie(testMoviesTable)).thenAnswer(
        (_) async => 1,
      );

      final result = await dataSource.removeWatchlistMovie(testMoviesTable);

      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      when(mockDbHelper.removeWatchlistMovie(testMoviesTable)).thenThrow(
        Exception(),
      );

      final call = dataSource.removeWatchlistMovie(testMoviesTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    int id = 1;

    test('should return Movie Detail Table when data is found', () async {
      when(mockDbHelper.getMovieById(id)).thenAnswer(
        (_) async => testMoviesMap,
      );

      final result = await dataSource.getMovieById(id);

      expect(result, testMoviesTable);
    });

    test('should return null when data is not found', () async {
      when(mockDbHelper.getMovieById(id)).thenAnswer((_) async => null);

      final result = await dataSource.getMovieById(id);

      expect(result, null);
    });
  });

  group('Get Watchlist Movies', () {
    test('should return list of MovieTable from database', () async {
      when(mockDbHelper.getWatchlistMovies()).thenAnswer(
        (_) async => [testMoviesMap],
      );

      final result = await dataSource.getWatchlistMovies();

      expect(result, [testMoviesTable]);
    });
  });
}
