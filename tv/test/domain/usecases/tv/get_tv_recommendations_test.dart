import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTvRepository);
  });

  int id = 1;
  final tTv = <Tv>[];

  test('should get list of tv recommendations from the repository', () async {
    when(mockTvRepository.getTvRecommendations(id)).thenAnswer(
      (_) async => Right(tTv),
    );

    final result = await usecase.execute(id);

    expect(result, Right(tTv));
  });
}
