import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetWatchListStatusTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchListStatusTv(mockTvRepository);
  });

  test('should get watchlist status from repository', () async {
    when(mockTvRepository.isAddedToWatchlistTv(1)).thenAnswer(
      (_) async => true,
    );

    final result = await usecase.execute(1);

    expect(result, true);
  });
}
