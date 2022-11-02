import 'package:dicoding_ditonton_app/data/datasources/db/db_helper.dart';
import 'package:dicoding_ditonton_app/data/datasources/movies/movies_local_data_source.dart';
import 'package:dicoding_ditonton_app/data/datasources/movies/movies_remote_data_source.dart';
import 'package:dicoding_ditonton_app/domain/repositories/movies_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MoviesRepository,
  MoviesRemoteDataSource,
  MoviesLocalDataSource,
  DbHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
