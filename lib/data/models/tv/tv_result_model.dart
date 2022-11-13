import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';

class TvResultModel extends Equatable {
  const TvResultModel({
    this.backdropPath = "",
    this.posterPath = "",
    this.overview = "",
    this.firstAirDate = "",
    this.id = 0,
    this.name = "",
    this.voteAverage = 0,
  });

  final String backdropPath;
  final String posterPath;
  final String overview;
  final String firstAirDate;
  final int id;
  final String name;
  final double voteAverage;

  factory TvResultModel.fromJson(Map<String, dynamic> json) => TvResultModel(
        backdropPath: json["backdrop_path"] ?? "",
        posterPath: json["poster_path"] ?? "",
        overview: json["overview"] ?? "",
        firstAirDate: json["first_air_date"] ?? "",
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        voteAverage: json["vote_average"].toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "poster_path": posterPath,
        "overview": overview,
        "first_air_date": firstAirDate,
        "id": id,
        "name": name,
        "vote_average": voteAverage,
      };

  Tv toEntity() {
    return Tv(
      id: id,
      backdropPath: backdropPath,
      posterPath: posterPath,
      name: name,
      voteAverage: voteAverage,
      firstAirDate: firstAirDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        overview,
        backdropPath,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
      ];
}
