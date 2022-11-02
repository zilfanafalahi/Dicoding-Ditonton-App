import 'package:equatable/equatable.dart';

class TvSeason extends Equatable {
  const TvSeason({
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
