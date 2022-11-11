import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv/tv_season_detail.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetTvSeasonDetail {
  final TvRepository repository;

  GetTvSeasonDetail(this.repository);

  Future<Either<Failure, TvSeasonDetail>> execute(int id, int seasonNumber) {
    return repository.getTvSeasonDetail(id, seasonNumber);
  }
}
