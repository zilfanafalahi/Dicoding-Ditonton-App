import 'package:dicoding_ditonton_app/data/datasources/db/db_helper.dart';
import 'package:dicoding_ditonton_app/data/datasources/movies/movies_local_data_source.dart';
import 'package:dicoding_ditonton_app/data/datasources/movies/movies_remote_data_source.dart';
import 'package:dicoding_ditonton_app/domain/repositories/movies_repository.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MoviesRepository,
  MoviesRemoteDataSource,
  MoviesLocalDataSource,
  DbHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
