import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/tv.dart';

import '../../../json_reader.dart';

void main() {
  const tResultsModel = TvResultModel(
    id: 1,
    overview: "Overview",
    backdropPath: "/backdrop_path.jpg",
    posterPath: "/poster_path.jpg",
    firstAirDate: "2022-10-25",
    name: "Name",
    voteAverage: 8.5,
  );

  const tTvResponse = TvResponse(results: <TvResultModel>[tResultsModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(
          'dummy_data/tv/tv_on_the_air.json',
        ),
      );

      final result = TvResponse.fromJson(jsonMap);

      expect(result, tTvResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvResponse.toJson();
      final expectedJsonMap = {
        "results": [
          {
            "id": 1,
            "overview": "Overview",
            "backdrop_path": "/backdrop_path.jpg",
            "poster_path": "/poster_path.jpg",
            "first_air_date": "2022-10-25",
            "name": "Name",
            "vote_average": 8.5,
          }
        ],
      };

      expect(result, expectedJsonMap);
    });
  });
}
