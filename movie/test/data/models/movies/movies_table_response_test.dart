import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';

import '../../../json_reader.dart';

void main() {
  const tMoviesTable = MoviesTable(
    id: 1,
    posterPath: "/poster_path.jpg",
    title: "Title",
    voteAverage: 8.5,
    releaseDate: "2022-10-25",
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(
          'dummy_data/movies/movies_table.json',
        ),
      );

      final result = MoviesTable.fromJson(jsonMap);

      expect(result, tMoviesTable);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tMoviesTable.toJson();
      final expectedJsonMap = {
        "id": 1,
        "posterPath": "/poster_path.jpg",
        "title": "Title",
        "voteAverage": 8.5,
        "releaseDate": "2022-10-25",
      };

      expect(result, expectedJsonMap);
    });
  });
}
