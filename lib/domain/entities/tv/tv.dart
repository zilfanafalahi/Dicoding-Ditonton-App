import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  const Tv({
    this.id = 0,
    this.backdropPath = "",
    this.posterPath = "",
    this.name = "",
    this.voteAverage = 0,
    this.firstAirDate = "",
  });

  const Tv.watchlist({
    this.id = 0,
    this.backdropPath = "",
    this.posterPath = "",
    this.name = "",
    this.voteAverage = 0,
    this.firstAirDate = "",
  });

  final int id;
  final String backdropPath;
  final String posterPath;
  final String name;
  final double voteAverage;
  final String firstAirDate;

  @override
  List<Object?> get props => [
        id,
        backdropPath,
        posterPath,
        name,
        voteAverage,
        firstAirDate,
      ];
}
