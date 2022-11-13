import 'package:dicoding_ditonton_app/domain/entities/genre.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  const TvDetail({
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

  final List<Genre> genres;
  final int id;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final List<int> episodeRunTime;
  final String name;
  final double voteAverage;
  final List<TvSeason> seasons;

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
