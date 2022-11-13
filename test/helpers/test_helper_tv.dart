import 'package:dicoding_ditonton_app/data/datasources/db/db_helper.dart';
import 'package:dicoding_ditonton_app/data/datasources/tv/tv_local_data_source.dart';
import 'package:dicoding_ditonton_app/data/datasources/tv/tv_remote_data_source.dart';
import 'package:dicoding_ditonton_app/domain/repositories/tv_repository.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DbHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
