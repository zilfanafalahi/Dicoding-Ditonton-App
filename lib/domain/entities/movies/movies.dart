import 'package:equatable/equatable.dart';

class Movies extends Equatable {
  const Movies({
    this.id = 0,
    this.backdropPath = "",
    this.posterPath = "",
    this.title = "",
    this.voteAverage = 0,
    this.releaseDate = "",
  });

  const Movies.watchlist({
    this.id = 0,
    this.backdropPath = "",
    this.posterPath = "",
    this.title = "",
    this.voteAverage = 0,
    this.releaseDate = "",
  });

  final int id;
  final String backdropPath;
  final String posterPath;
  final String title;
  final double voteAverage;
  final String releaseDate;

  @override
  List<Object?> get props => [
        id,
        backdropPath,
        posterPath,
        title,
        voteAverage,
        releaseDate,
      ];
}
