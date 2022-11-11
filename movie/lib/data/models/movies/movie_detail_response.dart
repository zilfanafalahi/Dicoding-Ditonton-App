import 'package:equatable/equatable.dart';
import 'package:movie/data/models/genre_model.dart';
import 'package:movie/domain/entities/movies/movies_detail.dart';

class MovieDetailResponse extends Equatable {
  const MovieDetailResponse({
    this.genres = const [],
    this.id = 0,
    this.overview = "",
    this.posterPath = "",
    this.releaseDate = "",
    this.runtime = 0,
    this.title = "",
    this.voteAverage = 0,
  });

  final List<GenreModel> genres;
  final int id;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      MovieDetailResponse(
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"] ?? 0,
        overview: json["overview"] ?? "",
        posterPath: json["poster_path"] ?? "",
        releaseDate: json["release_date"] ?? "",
        runtime: json["runtime"] ?? 0,
        title: json["title"] ?? "",
        voteAverage: json["vote_average"].toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "overview": overview,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "runtime": runtime,
        "title": title,
        "vote_average": voteAverage,
      };

  MoviesDetail toEntity() {
    return MoviesDetail(
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      overview: overview,
      posterPath: posterPath,
      releaseDate: releaseDate,
      runtime: runtime,
      title: title,
      voteAverage: voteAverage,
    );
  }

  @override
  List<Object?> get props => [
        genres,
        id,
        overview,
        posterPath,
        releaseDate,
        runtime,
        title,
        voteAverage,
      ];
}
