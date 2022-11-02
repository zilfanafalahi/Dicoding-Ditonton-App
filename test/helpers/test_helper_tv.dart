import 'package:dicoding_ditonton_app/data/datasources/db/db_helper.dart';
import 'package:dicoding_ditonton_app/data/datasources/tv/tv_local_data_source.dart';
import 'package:dicoding_ditonton_app/data/datasources/tv/tv_remote_data_source.dart';
import 'package:dicoding_ditonton_app/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DbHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
