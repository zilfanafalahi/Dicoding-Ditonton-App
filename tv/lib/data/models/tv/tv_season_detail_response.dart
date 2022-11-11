import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv/tv_episode_model.dart';
import 'package:tv/domain/entities/tv/tv_season_detail.dart';

class TvSeasonDetailResponse extends Equatable {
  const TvSeasonDetailResponse({
    this.id = 0,
    this.seasonNumber = 0,
    this.name = "",
    this.episodes = const [],
  });

  final int id;
  final int seasonNumber;
  final String name;
  final List<TvEpisodeModel> episodes;

  factory TvSeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeasonDetailResponse(
        id: json["id"] ?? 0,
        seasonNumber: json["season_number"] ?? 0,
        name: json["name"] ?? "",
        episodes: List<TvEpisodeModel>.from(
            json["episodes"].map((x) => TvEpisodeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "season_number": seasonNumber,
        "name": name,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
      };

  TvSeasonDetail toEntity() {
    return TvSeasonDetail(
      id: id,
      seasonNumber: seasonNumber,
      name: name,
      episodes: episodes.map((episode) => episode.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        seasonNumber,
        name,
        episodes,
      ];
}
