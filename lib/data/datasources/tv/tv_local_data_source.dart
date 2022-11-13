import 'package:dicoding_ditonton_app/common/exception.dart';
import 'package:dicoding_ditonton_app/data/datasources/db/db_helper.dart';
import 'package:dicoding_ditonton_app/data/models/tv/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTv(TvTable tv);
  Future<String> removeWatchlistTv(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DbHelper dbHelper;

  TvLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<String> insertWatchlistTv(TvTable tv) async {
    try {
      await dbHelper.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvTable tv) async {
    try {
      await dbHelper.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await dbHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await dbHelper.getWatchlistTv();
    return result.map((data) => TvTable.fromJson(data)).toList();
  }
}
