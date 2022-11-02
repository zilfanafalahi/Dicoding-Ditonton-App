import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies_detail.dart';
import 'package:dicoding_ditonton_app/domain/repositories/movies_repository.dart';

class GetMovieDetail {
  final MoviesRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MoviesDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
