import 'package:dicoding_ditonton_app/domain/entities/tv/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvSeasonModel extends Equatable {
  const TvSeasonModel({
    this.airDate = "",
    this.episodeCount = 0,
    this.id = 0,
    this.name = "",
    this.posterPath = "",
    this.seasonNumber = 0,
  });

  final String airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String posterPath;
  final int seasonNumber;

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) => TvSeasonModel(
        airDate: json["air_date"] ?? "",
        episodeCount: json["episode_count"] ?? 0,
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        posterPath: json["poster_path"] ?? "",
        seasonNumber: json["season_number"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  TvSeason toEntity() {
    return TvSeason(
      airDate: airDate,
      episodeCount: episodeCount,
      id: id,
      name: name,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        posterPath,
        seasonNumber,
      ];
}
