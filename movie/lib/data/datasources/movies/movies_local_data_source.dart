import 'package:common/common/exception.dart';
import 'package:movie/data/datasources/db/movies_db_helper.dart';
import 'package:movie/data/models/movies/movies_table.dart';

abstract class MoviesLocalDataSource {
  Future<String> insertWatchlistMovie(MoviesTable movie);
  Future<String> removeWatchlistMovie(MoviesTable movie);
  Future<MoviesTable?> getMovieById(int id);
  Future<List<MoviesTable>> getWatchlistMovies();
}

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final MoviesDbHelper moviesDbHelper;

  MoviesLocalDataSourceImpl({required this.moviesDbHelper});

  @override
  Future<String> insertWatchlistMovie(MoviesTable movie) async {
    try {
      await moviesDbHelper.insertWatchlistMovie(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistMovie(MoviesTable movie) async {
    try {
      await moviesDbHelper.removeWatchlistMovie(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MoviesTable?> getMovieById(int id) async {
    final result = await moviesDbHelper.getMovieById(id);
    if (result != null) {
      return MoviesTable.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MoviesTable>> getWatchlistMovies() async {
    final result = await moviesDbHelper.getWatchlistMovies();
    return result.map((data) => MoviesTable.fromJson(data)).toList();
  }
}
