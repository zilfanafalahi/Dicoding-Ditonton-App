import 'dart:convert';
import 'package:dicoding_ditonton_app/data/models/genre_model.dart';
import 'package:dicoding_ditonton_app/data/models/tv/tv_detail_response.dart';
import 'package:dicoding_ditonton_app/data/models/tv/tv_season_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  const tTvDetail = TvDetailResponse(
    genres: [GenreModel(id: 1, name: "Action")],
    posterPath: "/poster_path.jpg",
    overview: "Overview",
    firstAirDate: "2022-10-25",
    episodeRunTime: [90],
    id: 1,
    name: "Name",
    voteAverage: 8.5,
    seasons: [
      TvSeasonModel(
        airDate: "2022-10-25",
        episodeCount: 1,
        id: 1,
        name: "Name",
        posterPath: "/poster_path.jpg",
        seasonNumber: 1,
      )
    ],
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(
          'dummy_data/tv/tv_detail_response.json',
        ),
      );

      final result = TvDetailResponse.fromJson(jsonMap);

      expect(result, tTvDetail);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvDetail.toJson();
      final expectedJsonMap = {
        "genres": [
          {"id": 1, "name": "Action"}
        ],
        "poster_path": "/poster_path.jpg",
        "overview": "Overview",
        "first_air_date": "2022-10-25",
        "episode_run_time": [90],
        "id": 1,
        "name": "Name",
        "vote_average": 8.5,
        "seasons": [
          {
            "air_date": "2022-10-25",
            "episode_count": 1,
            "id": 1,
            "name": "Name",
            "poster_path": "/poster_path.jpg",
            "season_number": 1,
          }
        ],
      };

      expect(result, expectedJsonMap);
    });
  });
}
