import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  int id = 1;

  test('should get tv detail from the repository', () async {
    when(mockTvRepository.getTvDetail(id)).thenAnswer(
      (_) async => const Right(testTvDetail),
    );

    final result = await usecase.execute(id);

    expect(result, const Right(testTvDetail));
  });
}
