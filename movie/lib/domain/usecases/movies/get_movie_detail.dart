import 'package:common/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movies/movies_detail.dart';
import 'package:movie/domain/repositories/movies_repository.dart';

class GetMovieDetail {
  final MoviesRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MoviesDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
