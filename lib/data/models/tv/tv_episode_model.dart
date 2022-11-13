import 'package:dicoding_ditonton_app/domain/entities/tv/tv_episode.dart';
import 'package:equatable/equatable.dart';

class TvEpisodeModel extends Equatable {
  const TvEpisodeModel({
    this.id = 0,
    this.episodeNumber = 0,
    this.seasonNumber = 0,
    this.name = "",
    this.overview = "",
    this.stillPath = "",
    this.voteAverage = 0,
    this.airDate = "",
    this.runtime = 0,
  });

  final int id;
  final int episodeNumber;
  final int seasonNumber;
  final String name;
  final String overview;
  final String stillPath;
  final double voteAverage;
  final String airDate;
  final int runtime;

  factory TvEpisodeModel.fromJson(Map<String, dynamic> json) => TvEpisodeModel(
        id: json["id"] ?? 0,
        episodeNumber: json["episode_number"] ?? 0,
        seasonNumber: json["season_number"] ?? 0,
        name: json["name"] ?? "",
        overview: json["overview"] ?? "",
        stillPath: json["still_path"] ?? "",
        voteAverage: json["vote_average"].toDouble() ?? 0,
        airDate: json["air_date"] ?? "",
        runtime: json["runtime"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "episode_number": episodeNumber,
        "season_number": seasonNumber,
        "name": name,
        "overview": overview,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "air_date": airDate,
        "runtime": runtime,
      };

  TvEpisode toEntity() {
    return TvEpisode(
      id: id,
      episodeNumber: episodeNumber,
      seasonNumber: seasonNumber,
      name: name,
      overview: overview,
      stillPath: stillPath,
      voteAverage: voteAverage,
      airDate: airDate,
      runtime: runtime,
    );
  }

  @override
  List<Object?> get props => [
        id,
        episodeNumber,
        seasonNumber,
        name,
        overview,
        stillPath,
        voteAverage,
        airDate,
        runtime,
      ];
}
