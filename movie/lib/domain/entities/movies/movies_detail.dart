import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/genre.dart';

class MoviesDetail extends Equatable {
  const MoviesDetail({
    this.genres = const [],
    this.id = 0,
    this.overview = "",
    this.posterPath = "",
    this.releaseDate = "",
    this.runtime = 0,
    this.title = "",
    this.voteAverage = 0,
  });

  final List<Genre> genres;
  final int id;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;

  @override
  List<Object?> get props => [
        genres,
        id,
        overview,
        posterPath,
        releaseDate,
        runtime,
        title,
        voteAverage,
      ];
}
