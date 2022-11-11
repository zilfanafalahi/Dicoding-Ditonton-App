import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movies/movies.dart';

class MoviesResultModel extends Equatable {
  const MoviesResultModel({
    this.backdropPath = "",
    this.posterPath = "",
    this.overview = "",
    this.releaseDate = "",
    this.id = 0,
    this.title = "",
    this.voteAverage = 0,
  });

  final String backdropPath;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final int id;
  final String title;
  final double voteAverage;

  factory MoviesResultModel.fromJson(Map<String, dynamic> json) =>
      MoviesResultModel(
        backdropPath: json["backdrop_path"] ?? "",
        posterPath: json["poster_path"] ?? "",
        overview: json["overview"] ?? "",
        releaseDate: json["release_date"] ?? "",
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        voteAverage: json["vote_average"].toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "poster_path": posterPath,
        "overview": overview,
        "release_date": releaseDate,
        "id": id,
        "title": title,
        "vote_average": voteAverage,
      };

  Movies toEntity() {
    return Movies(
      id: id,
      backdropPath: backdropPath,
      posterPath: posterPath,
      title: title,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        overview,
        backdropPath,
        posterPath,
        releaseDate,
        title,
        voteAverage,
      ];
}
