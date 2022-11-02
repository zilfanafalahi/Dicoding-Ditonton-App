import 'package:dicoding_ditonton_app/domain/repositories/movies_repository.dart';

class GetWatchListStatusMovie {
  final MoviesRepository repository;

  GetWatchListStatusMovie(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistMovie(id);
  }
}
