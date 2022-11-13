import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTv(mockTvRepository);
  });

  final tTv = <Tv>[];

  group('GetPopularTv Tests', () {
    group('Execute', () {
      test(
          'should get list of popular tv from the repository when execute function is called',
          () async {
        when(mockTvRepository.getPopularTv()).thenAnswer(
          (_) async => Right(tTv),
        );

        final result = await usecase.execute();

        expect(result, Right(tTv));
      });
    });
  });
}
