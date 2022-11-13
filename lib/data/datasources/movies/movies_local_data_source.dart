import 'package:dicoding_ditonton_app/common/exception.dart';
import 'package:dicoding_ditonton_app/data/datasources/db/db_helper.dart';
import 'package:dicoding_ditonton_app/data/models/movies/movies_table.dart';

abstract class MoviesLocalDataSource {
  Future<String> insertWatchlistMovie(MoviesTable movie);
  Future<String> removeWatchlistMovie(MoviesTable movie);
  Future<MoviesTable?> getMovieById(int id);
  Future<List<MoviesTable>> getWatchlistMovies();
}

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final DbHelper dbHelper;

  MoviesLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<String> insertWatchlistMovie(MoviesTable movie) async {
    try {
      await dbHelper.insertWatchlistMovie(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistMovie(MoviesTable movie) async {
    try {
      await dbHelper.removeWatchlistMovie(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MoviesTable?> getMovieById(int id) async {
    final result = await dbHelper.getMovieById(id);
    if (result != null) {
      return MoviesTable.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MoviesTable>> getWatchlistMovies() async {
    final result = await dbHelper.getWatchlistMovies();
    return result.map((data) => MoviesTable.fromJson(data)).toList();
  }
}
