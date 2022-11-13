import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late SaveWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchlistTv(mockTvRepository);
  });

  test('should save tv to the repository', () async {
    when(mockTvRepository.saveWatchlistTv(testTvDetail)).thenAnswer(
      (_) async => const Right('Added to Watchlist'),
    );

    final result = await usecase.execute(testTvDetail);

    verify(mockTvRepository.saveWatchlistTv(testTvDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
