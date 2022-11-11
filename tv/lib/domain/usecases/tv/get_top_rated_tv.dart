import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetTopRatedTv {
  final TvRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTv();
  }
}
