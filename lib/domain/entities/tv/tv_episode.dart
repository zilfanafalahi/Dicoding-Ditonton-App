import 'package:equatable/equatable.dart';

class TvEpisode extends Equatable {
  const TvEpisode({
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
