import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_on_the_air_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetOnTheAirTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetOnTheAirTv(mockTvRepository);
  });

  final tTv = <Tv>[];

  test('should get list of on the air tv from the repository', () async {
    when(mockTvRepository.getOnTheAirTv()).thenAnswer(
      (_) async => Right(tTv),
    );

    final result = await usecase.execute();

    expect(result, Right(tTv));
  });
}
