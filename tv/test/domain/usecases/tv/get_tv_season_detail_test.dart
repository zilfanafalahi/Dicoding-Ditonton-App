import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTvSeasonDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvSeasonDetail(mockTvRepository);
  });

  int id = 1;
  int seasonNumber = 1;

  test('should get list of tv season detail from the repository', () async {
    when(mockTvRepository.getTvSeasonDetail(id, seasonNumber)).thenAnswer(
      (_) async => const Right(testTvSeasonDetail),
    );

    final result = await usecase.execute(id, seasonNumber);

    expect(result, const Right(testTvSeasonDetail));
  });
}
