import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late RemoveWatchlistTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlistTv(mockTvRepository);
  });

  test('should remove watchlist tv from repository', () async {
    when(mockTvRepository.removeWatchlistTv(testTvDetail)).thenAnswer(
      (_) async => const Right('Removed from watchlist'),
    );

    final result = await usecase.execute(testTvDetail);

    verify(mockTvRepository.removeWatchlistTv(testTvDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
