import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies_detail.dart';
import 'package:equatable/equatable.dart';

class MoviesTable extends Equatable {
  const MoviesTable({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
  });

  final int id;
  final String posterPath;
  final String title;
  final double voteAverage;
  final String releaseDate;

  factory MoviesTable.fromJson(Map<String, dynamic> json) => MoviesTable(
        id: json["id"] ?? 0,
        posterPath: json["posterPath"] ?? "",
        title: json["title"] ?? "",
        voteAverage: json["voteAverage"].toDouble() ?? 0,
        releaseDate: json["releaseDate"] ?? "",
      );

  factory MoviesTable.fromEntity(MoviesDetail movie) => MoviesTable(
        id: movie.id,
        posterPath: movie.posterPath,
        title: movie.title,
        voteAverage: movie.voteAverage,
        releaseDate: movie.releaseDate,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "posterPath": posterPath,
        "title": title,
        "voteAverage": voteAverage,
        "releaseDate": releaseDate,
      };

  Movies toEntity() => Movies.watchlist(
        id: id,
        posterPath: posterPath,
        title: title,
        voteAverage: voteAverage,
        releaseDate: releaseDate,
      );

  @override
  List<Object?> get props => [
        id,
        posterPath,
        title,
        voteAverage,
        releaseDate,
      ];
}
