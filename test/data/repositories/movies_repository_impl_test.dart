import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/exception.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/data/models/genre_model.dart';
import 'package:dicoding_ditonton_app/data/models/movies/movie_detail_response.dart';
import 'package:dicoding_ditonton_app/data/models/movies/movies_result_model.dart';
import 'package:dicoding_ditonton_app/data/repositories/movies_repository_impl.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movies/dummy_objects_movies.dart';
import '../../helpers/test_helper_movies.mocks.dart';

void main() {
  late MoviesRepositoryImpl repository;
  late MockMoviesRemoteDataSource mockRemoteDataSource;
  late MockMoviesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMoviesRemoteDataSource();
    mockLocalDataSource = MockMoviesLocalDataSource();
    repository = MoviesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tMovieModel = MoviesResultModel(
    backdropPath: "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg",
    posterPath: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
    overview:
        "When an unexpected enemy emerges and threatens global safety and security, Nick Fury, director of the international peacekeeping agency known as S.H.I.E.L.D., finds himself in need of a team to pull the world back from the brink of disaster. Spanning the globe, a daring recruitment effort begins!",
    releaseDate: "2012-04-25",
    id: 24428,
    title: "The Avengers",
    voteAverage: 7.33,
  );

  const tMovie = Movies(
    backdropPath: "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg",
    posterPath: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
    releaseDate: "2012-04-25",
    id: 24428,
    title: "The Avengers",
    voteAverage: 7.33,
  );

  final tMovieModelList = <MoviesResultModel>[tMovieModel];
  final tMovieList = <Movies>[tMovie];

  group('Now Playing Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getNowPlayingMovies()).thenAnswer(
        (_) async => tMovieModelList,
      );

      final result = await repository.getNowPlayingMovies();

      verify(mockRemoteDataSource.getNowPlayingMovies());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getNowPlayingMovies()).thenThrow(
        ServerException(),
      );

      final result = await repository.getNowPlayingMovies();

      verify(mockRemoteDataSource.getNowPlayingMovies());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteDataSource.getNowPlayingMovies()).thenThrow(
        const SocketException('Failed to connect to the network'),
      );

      final result = await repository.getNowPlayingMovies();

      verify(mockRemoteDataSource.getNowPlayingMovies());
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure('Failed to connect to the network'),
          ),
        ),
      );
    });
  });

  group('Popular Movies', () {
    test('should return movie list when call to data source is success',
        () async {
      when(mockRemoteDataSource.getPopularMovies()).thenAnswer(
        (_) async => tMovieModelList,
      );

      final result = await repository.getPopularMovies();

      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getPopularMovies()).thenThrow(
        ServerException(),
      );

      final result = await repository.getPopularMovies();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getPopularMovies()).thenThrow(
        const SocketException('Failed to connect to the network'),
      );

      final result = await repository.getPopularMovies();

      expect(
        result,
        const Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
    });
  });

  group('Top Rated Movies', () {
    test('should return movie list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getTopRatedMovies()).thenAnswer(
        (_) async => tMovieModelList,
      );

      final result = await repository.getTopRatedMovies();

      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTopRatedMovies()).thenThrow(
        ServerException(),
      );

      final result = await repository.getTopRatedMovies();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getTopRatedMovies()).thenThrow(
        const SocketException('Failed to connect to the network'),
      );

      final result = await repository.getTopRatedMovies();

      expect(
        result,
        const Left(ConnectionFailure('Failed to connect to the network')),
      );
    });
  });

  group('Get Movie Detail', () {
    int id = 1;
    const tMovieResponse = MovieDetailResponse(
      genres: [GenreModel(id: 1, name: "Action")],
      id: 1,
      overview: "Overview",
      posterPath: "/poster_path.jpg",
      releaseDate: "2022-10-25",
      runtime: 90,
      title: "Title",
      voteAverage: 8.5,
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getMovieDetail(id)).thenAnswer(
        (_) async => tMovieResponse,
      );

      final result = await repository.getMovieDetail(id);

      verify(mockRemoteDataSource.getMovieDetail(id));
      expect(result, equals(const Right(testMoviesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getMovieDetail(id)).thenThrow(
        ServerException(),
      );

      final result = await repository.getMovieDetail(id);

      verify(mockRemoteDataSource.getMovieDetail(id));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteDataSource.getMovieDetail(id)).thenThrow(
        const SocketException(
          'Failed to connect to the network',
        ),
      );

      final result = await repository.getMovieDetail(id);

      verify(mockRemoteDataSource.getMovieDetail(id));
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure(
              'Failed to connect to the network',
            ),
          ),
        ),
      );
    });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MoviesResultModel>[];
    int id = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      when(mockRemoteDataSource.getMovieRecommendations(id)).thenAnswer(
        (_) async => tMovieList,
      );

      final result = await repository.getMovieRecommendations(id);

      verify(mockRemoteDataSource.getMovieRecommendations(id));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getMovieRecommendations(id)).thenThrow(
        ServerException(),
      );

      final result = await repository.getMovieRecommendations(id);

      verify(mockRemoteDataSource.getMovieRecommendations(id));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getMovieRecommendations(id)).thenThrow(
        const SocketException(
          'Failed to connect to the network',
        ),
      );

      final result = await repository.getMovieRecommendations(id);

      verify(mockRemoteDataSource.getMovieRecommendations(id));
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure(
              'Failed to connect to the network',
            ),
          ),
        ),
      );
    });
  });

  group('Seach Movies', () {
    String query = 'Avengers';

    test('should return movie list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.searchMovies(query)).thenAnswer(
        (_) async => tMovieModelList,
      );

      final result = await repository.searchMovies(query);

      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.searchMovies(query)).thenThrow(
        ServerException(),
      );

      final result = await repository.searchMovies(query);

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.searchMovies(query)).thenThrow(
        const SocketException('Failed to connect to the network'),
      );

      final result = await repository.searchMovies(query);

      expect(
        result,
        const Left(
          ConnectionFailure('Failed to connect to the network'),
        ),
      );
    });
  });

  group('Save Watchlist', () {
    test('should return success message when saving successful', () async {
      when(mockLocalDataSource.insertWatchlistMovie(testMoviesTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      final result = await repository.saveWatchlistMovie(testMoviesDetail);

      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockLocalDataSource.insertWatchlistMovie(testMoviesTable)).thenThrow(
        DatabaseException(
          'Failed to add watchlist',
        ),
      );

      final result = await repository.saveWatchlistMovie(testMoviesDetail);

      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when remove successful', () async {
      when(mockLocalDataSource.removeWatchlistMovie(testMoviesTable))
          .thenAnswer(
        (_) async => 'Removed from watchlist',
      );

      final result = await repository.removeWatchlistMovie(testMoviesDetail);

      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      when(mockLocalDataSource.removeWatchlistMovie(testMoviesTable)).thenThrow(
        DatabaseException(
          'Failed to remove watchlist',
        ),
      );

      final result = await repository.removeWatchlistMovie(testMoviesDetail);

      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get Watchlist Status', () {
    test('should return watch status whether data is found', () async {
      int id = 1;
      when(mockLocalDataSource.getMovieById(id)).thenAnswer((_) async => null);

      final result = await repository.isAddedToWatchlistMovie(id);

      expect(result, false);
    });
  });

  group('Get Watchlist Movies', () {
    test('should return list of Movies', () async {
      when(mockLocalDataSource.getWatchlistMovies()).thenAnswer(
        (_) async => [testMoviesTable],
      );

      final result = await repository.getWatchlistMovies();

      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovies]);
    });
  });
}
