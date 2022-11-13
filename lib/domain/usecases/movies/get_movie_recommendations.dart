import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/repositories/movies_repository.dart';

class GetMovieRecommendations {
  final MoviesRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movies>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
