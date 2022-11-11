import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopRatedTv(mockTvRepository);
  });

  final ttv = <Tv>[];

  test('should get list of tv from repository', () async {
    when(mockTvRepository.getTopRatedTv()).thenAnswer(
      (_) async => Right(ttv),
    );

    final result = await usecase.execute();

    expect(result, Right(ttv));
  });
}
