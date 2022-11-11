import 'package:common/common.dart';
import 'package:tv/data/datasources/db/tv_db_helper.dart';
import 'package:tv/data/models/tv/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTv(TvTable tv);
  Future<String> removeWatchlistTv(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final TvDbHelper tvDbHelper;

  TvLocalDataSourceImpl({required this.tvDbHelper});

  @override
  Future<String> insertWatchlistTv(TvTable tv) async {
    try {
      await tvDbHelper.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvTable tv) async {
    try {
      await tvDbHelper.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await tvDbHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await tvDbHelper.getWatchlistTv();
    return result.map((data) => TvTable.fromJson(data)).toList();
  }
}
