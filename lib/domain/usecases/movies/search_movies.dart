import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/repositories/movies_repository.dart';

class SearchMovies {
  final MoviesRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movies>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
