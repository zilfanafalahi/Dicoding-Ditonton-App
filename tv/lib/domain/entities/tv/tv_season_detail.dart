import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/tv_episode.dart';

class TvSeasonDetail extends Equatable {
  const TvSeasonDetail({
    this.id = 0,
    this.seasonNumber = 0,
    this.name = "",
    this.episodes = const [],
  });

  final int id;
  final int seasonNumber;
  final String name;
  final List<TvEpisode> episodes;

  @override
  List<Object?> get props => [
        id,
        seasonNumber,
        name,
        episodes,
      ];
}
