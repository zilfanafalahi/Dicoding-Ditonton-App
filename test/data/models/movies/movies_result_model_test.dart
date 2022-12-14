import 'package:dicoding_ditonton_app/data/models/movies/movies_result_model.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tResultModel = MoviesResultModel(
    backdropPath: "/backdrop_path.jpg",
    posterPath: "/poster_path.jpg",
    overview: "Overview",
    releaseDate: "2022-10-25",
    id: 1,
    title: "Title",
    voteAverage: 8.5,
  );

  const tMovies = Movies(
    id: 1,
    backdropPath: "/backdrop_path.jpg",
    posterPath: "/poster_path.jpg",
    title: "Title",
    voteAverage: 8.5,
    releaseDate: "2022-10-25",
  );

  test('should be a subclass of movie entity', () async {
    final result = tResultModel.toEntity();
    expect(result, tMovies);
  });
}
