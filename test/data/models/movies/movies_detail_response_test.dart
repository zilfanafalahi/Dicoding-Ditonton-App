import 'dart:convert';
import 'package:dicoding_ditonton_app/data/models/genre_model.dart';
import 'package:dicoding_ditonton_app/data/models/movies/movie_detail_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tMoviesDetail = MovieDetailResponse(
    genres: [GenreModel(id: 1, name: "Action")],
    posterPath: "/poster_path.jpg",
    overview: "Overview",
    releaseDate: "2022-10-25",
    runtime: 90,
    id: 1,
    title: "Title",
    voteAverage: 8.5,
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(
          'dummy_data/movies/movie_detail_response.json',
        ),
      );

      final result = MovieDetailResponse.fromJson(jsonMap);

      expect(result, tMoviesDetail);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tMoviesDetail.toJson();
      final expectedJsonMap = {
        "genres": [
          {"id": 1, "name": "Action"}
        ],
        "poster_path": "/poster_path.jpg",
        "overview": "Overview",
        "release_date": "2022-10-25",
        "runtime": 90,
        "id": 1,
        "title": "Title",
        "vote_average": 8.5,
      };

      expect(result, expectedJsonMap);
    });
  });
}
