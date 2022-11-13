import 'dart:convert';
import 'package:dicoding_ditonton_app/data/models/movies/movies_response.dart';
import 'package:dicoding_ditonton_app/data/models/movies/movies_result_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tResultsModel = MoviesResultModel(
    backdropPath: "/backdrop_path.jpg",
    posterPath: "/poster_path.jpg",
    overview: "Overview",
    releaseDate: "2022-10-25",
    id: 1,
    title: "Title",
    voteAverage: 8.5,
  );

  const tMoviesResponse = MoviesResponse(
    results: <MoviesResultModel>[tResultsModel],
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(
          'dummy_data/movies/movies_now_playing.json',
        ),
      );

      final result = MoviesResponse.fromJson(jsonMap);

      expect(result, tMoviesResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tMoviesResponse.toJson();
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/backdrop_path.jpg",
            "poster_path": "/poster_path.jpg",
            "overview": "Overview",
            "release_date": "2022-10-25",
            "id": 1,
            "title": "Title",
            "vote_average": 8.5,
          }
        ],
      };

      expect(result, expectedJsonMap);
    });
  });
}
