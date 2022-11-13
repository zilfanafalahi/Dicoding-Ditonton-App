import 'package:dicoding_ditonton_app/data/models/tv/tv_result_model.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tResultModel = TvResultModel(
    id: 1,
    overview: "Overview",
    backdropPath: "/backdrop_path.jpg",
    posterPath: "/poster_path.jpg",
    firstAirDate: "2022-10-25",
    name: "Name",
    voteAverage: 8.5,
  );

  const tTv = Tv(
    id: 1,
    backdropPath: "/backdrop_path.jpg",
    posterPath: "/poster_path.jpg",
    firstAirDate: "2022-10-25",
    name: "Name",
    voteAverage: 8.5,
  );

  test('should be a subclass of tv entity', () async {
    final result = tResultModel.toEntity();
    expect(result, tTv);
  });
}
