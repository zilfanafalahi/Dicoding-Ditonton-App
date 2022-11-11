import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';

@GenerateMocks([
  MoviesRepository,
  MoviesRemoteDataSource,
  MoviesLocalDataSource,
  MoviesDbHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
