import 'package:movie/movie.dart';

const testMovies = Movies(
  id: 24428,
  backdropPath: "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg",
  posterPath: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
  title: "The Avengers",
  voteAverage: 7.33,
  releaseDate: "2012-04-25",
);

final testMoviesList = [testMovies];

const testMoviesDetail = MoviesDetail(
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: "Overview",
  posterPath: "/poster_path.jpg",
  releaseDate: "2022-10-25",
  runtime: 90,
  title: "Title",
  voteAverage: 8.5,
);

const testWatchlistMovies = Movies.watchlist(
  id: 1,
  posterPath: "/poster_path.jpg",
  title: "Title",
  voteAverage: 8.5,
  releaseDate: "2022-10-25",
);

const testMoviesTable = MoviesTable(
  id: 1,
  posterPath: "/poster_path.jpg",
  title: "Title",
  voteAverage: 8.5,
  releaseDate: "2022-10-25",
);

final testMoviesMap = {
  "id": 1,
  "posterPath": "/poster_path.jpg",
  "title": "Title",
  "voteAverage": 8.5,
  "releaseDate": "2022-10-25",
};
