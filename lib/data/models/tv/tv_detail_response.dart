import 'package:dicoding_ditonton_app/data/models/genre_model.dart';
import 'package:dicoding_ditonton_app/data/models/tv/tv_season_model.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  const TvDetailResponse({
    this.genres = const [],
    this.id = 0,
    this.overview = "",
    this.posterPath = "",
    this.firstAirDate = "",
    this.episodeRunTime = const [],
    this.name = "",
    this.voteAverage = 0,
    this.seasons = const [],
  });

  final List<GenreModel> genres;
  final int id;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final List<int> episodeRunTime;
  final String name;
  final double voteAverage;
  final List<TvSeasonModel> seasons;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"] ?? 0,
        overview: json["overview"] ?? "",
        posterPath: json["poster_path"] ?? "",
        firstAirDate: json["first_air_date"] ?? "",
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        name: json["name"] ?? "",
        voteAverage: json["vote_average"].toDouble() ?? 0,
        seasons: List<TvSeasonModel>.from(
            json["seasons"].map((x) => TvSeasonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "overview": overview,
        "poster_path": posterPath,
        "first_air_date": firstAirDate,
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "name": name,
        "vote_average": voteAverage,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
      };

  TvDetail toEntity() {
    return TvDetail(
      genres: genres.map((genre) => genre.toEntity()).toList(),
      id: id,
      overview: overview,
      posterPath: posterPath,
      firstAirDate: firstAirDate,
      episodeRunTime: episodeRunTime,
      name: name,
      voteAverage: voteAverage,
      seasons: seasons.map((season) => season.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        genres,
        id,
        overview,
        posterPath,
        firstAirDate,
        episodeRunTime,
        name,
        voteAverage,
        seasons,
      ];
}
