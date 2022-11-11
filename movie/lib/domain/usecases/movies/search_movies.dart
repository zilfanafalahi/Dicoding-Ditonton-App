import 'package:common/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movies/movies.dart';
import 'package:movie/domain/repositories/movies_repository.dart';

class SearchMovies {
  final MoviesRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movies>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
