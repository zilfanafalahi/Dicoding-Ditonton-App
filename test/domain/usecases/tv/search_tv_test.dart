import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTv(mockTvRepository);
  });

  final tTv = <Tv>[];
  String query = 'One Piece';

  test('should get list of search tv from the repository', () async {
    when(mockTvRepository.searchTv(query)).thenAnswer(
      (_) async => Right(tTv),
    );

    final result = await usecase.execute(query);

    expect(result, Right(tTv));
  });
}
