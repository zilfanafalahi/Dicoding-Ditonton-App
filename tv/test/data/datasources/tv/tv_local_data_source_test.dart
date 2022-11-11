import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockTvDbHelper mockTvDbHelper;

  setUp(() {
    mockTvDbHelper = MockTvDbHelper();
    dataSource = TvLocalDataSourceImpl(tvDbHelper: mockTvDbHelper);
  });

  group('Save Watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      when(mockTvDbHelper.insertWatchlistTv(testTvTable)).thenAnswer(
        (_) async => 1,
      );

      final result = await dataSource.insertWatchlistTv(testTvTable);

      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      when(mockTvDbHelper.insertWatchlistTv(testTvTable))
          .thenThrow(Exception());

      final call = dataSource.insertWatchlistTv(testTvTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      when(mockTvDbHelper.removeWatchlistTv(testTvTable)).thenAnswer(
        (_) async => 1,
      );

      final result = await dataSource.removeWatchlistTv(testTvTable);

      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      when(mockTvDbHelper.removeWatchlistTv(testTvTable))
          .thenThrow(Exception());

      final call = dataSource.removeWatchlistTv(testTvTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    int id = 1;

    test('should return Tv Detail Table when data is found', () async {
      when(mockTvDbHelper.getTvById(id)).thenAnswer((_) async => testTvMap);

      final result = await dataSource.getTvById(id);

      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      when(mockTvDbHelper.getTvById(id)).thenAnswer((_) async => null);

      final result = await dataSource.getTvById(id);

      expect(result, null);
    });
  });

  group('Get Watchlist Movies', () {
    test('should return list of TvTable from database', () async {
      when(mockTvDbHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);

      final result = await dataSource.getWatchlistTv();

      expect(result, [testTvTable]);
    });
  });
}
