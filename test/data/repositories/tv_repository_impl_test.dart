import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/exception.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/data/models/genre_model.dart';
import 'package:dicoding_ditonton_app/data/models/tv/tv_detail_response.dart';
import 'package:dicoding_ditonton_app/data/models/tv/tv_result_model.dart';
import 'package:dicoding_ditonton_app/data/models/tv/tv_season_model.dart';
import 'package:dicoding_ditonton_app/data/repositories/tv_repository_impl.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tTvModel = TvResultModel(
    id: 37854,
    overview:
        "Years ago, the fearsome Pirate King, Gol D. Roger was executed leaving a huge pile of treasure and the famous \"One Piece\" behind. Whoever claims the \"One Piece\" will be named the new King of the Pirates. Monkey D. Luffy, a boy who consumed a \"Devil Fruit,\" decides to follow in the footsteps of his idol, the pirate Shanks, and find the One Piece. It helps, of course, that his body has the properties of rubber and that he's surrounded by a bevy of skilled fighters and thieves to help him along the way. Luffy will do anything to get the One Piece and become King of the Pirates!",
    backdropPath: "/mBxsapX4DNhH1XkOlLp15He5sxL.jpg",
    posterPath: "/e3NBGiAifW9Xt8xD5tpARskjccO.jpg",
    firstAirDate: "1999-10-20",
    name: "One Piece",
    voteAverage: 8.7,
  );

  const tTv = Tv(
    id: 37854,
    backdropPath: "/mBxsapX4DNhH1XkOlLp15He5sxL.jpg",
    posterPath: "/e3NBGiAifW9Xt8xD5tpARskjccO.jpg",
    firstAirDate: "1999-10-20",
    name: "One Piece",
    voteAverage: 8.7,
  );

  final tTvModelList = <TvResultModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('On The Air Tv', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getOnTheAirTv()).thenAnswer(
        (_) async => tTvModelList,
      );

      final result = await repository.getOnTheAirTv();

      verify(mockRemoteDataSource.getOnTheAirTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getOnTheAirTv()).thenThrow(ServerException());

      final result = await repository.getOnTheAirTv();

      verify(mockRemoteDataSource.getOnTheAirTv());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteDataSource.getOnTheAirTv()).thenThrow(
        const SocketException(
          'Failed to connect to the network',
        ),
      );

      final result = await repository.getOnTheAirTv();

      verify(mockRemoteDataSource.getOnTheAirTv());
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

  group('Popular Tv', () {
    test('should return tv list when call to data source is success', () async {
      when(mockRemoteDataSource.getPopularTv()).thenAnswer(
        (_) async => tTvModelList,
      );

      final result = await repository.getPopularTv();

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());

      final result = await repository.getPopularTv();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getPopularTv())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getPopularTv();

      expect(
        result,
        const Left(
          ConnectionFailure(
            'Failed to connect to the network',
          ),
        ),
      );
    });
  });

  group('Top Rated Tv', () {
    test('should return tv list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getTopRatedTv()).thenAnswer(
        (_) async => tTvModelList,
      );

      final result = await repository.getTopRatedTv();

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());

      final result = await repository.getTopRatedTv();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getTopRatedTv()).thenThrow(
        const SocketException(
          'Failed to connect to the network',
        ),
      );

      final result = await repository.getTopRatedTv();

      expect(
        result,
        const Left(
          ConnectionFailure(
            'Failed to connect to the network',
          ),
        ),
      );
    });
  });

  group('Get Tv Detail', () {
    int id = 1;
    const tTvResponse = TvDetailResponse(
      genres: [GenreModel(id: 1, name: "Action")],
      id: 1,
      overview: "Overview",
      posterPath: "/poster_path.jpg",
      firstAirDate: "2022-10-25",
      episodeRunTime: [90],
      name: "Name",
      voteAverage: 8.5,
      seasons: [
        TvSeasonModel(
          airDate: "2022-10-25",
          episodeCount: 1,
          id: 1,
          name: "Name",
          posterPath: "/poster_path.jpg",
          seasonNumber: 1,
        )
      ],
    );

    test(
        'should return Tv data when the call to remote data source is successful',
        () async {
      when(mockRemoteDataSource.getTvDetail(id)).thenAnswer(
        (_) async => tTvResponse,
      );

      final result = await repository.getTvDetail(id);

      verify(mockRemoteDataSource.getTvDetail(id));
      expect(result, equals(const Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTvDetail(id)).thenThrow(ServerException());

      final result = await repository.getTvDetail(id);

      verify(mockRemoteDataSource.getTvDetail(id));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteDataSource.getTvDetail(id))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTvDetail(id);

      verify(mockRemoteDataSource.getTvDetail(id));
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

  group('Get Tv Recommendations', () {
    final tTvList = <TvResultModel>[];
    int id = 1;

    test('should return data (tv list) when the call is successful', () async {
      when(mockRemoteDataSource.getTvRecommendations(id)).thenAnswer(
        (_) async => tTvList,
      );

      final result = await repository.getTvRecommendations(id);

      verify(mockRemoteDataSource.getTvRecommendations(id));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTvRecommendations(id)).thenThrow(
        ServerException(),
      );

      final result = await repository.getTvRecommendations(id);

      verify(mockRemoteDataSource.getTvRecommendations(id));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getTvRecommendations(id)).thenThrow(
        const SocketException(
          'Failed to connect to the network',
        ),
      );

      final result = await repository.getTvRecommendations(id);

      verify(mockRemoteDataSource.getTvRecommendations(id));
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

  group('Seach Tv', () {
    String query = 'One Piece';

    test('should return tv list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.searchTv(query)).thenAnswer(
        (_) async => tTvModelList,
      );

      final result = await repository.searchTv(query);

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.searchTv(query)).thenThrow(ServerException());

      final result = await repository.searchTv(query);

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.searchTv(query)).thenThrow(
        const SocketException(
          'Failed to connect to the network',
        ),
      );

      final result = await repository.searchTv(query);

      expect(
        result,
        const Left(
          ConnectionFailure(
            'Failed to connect to the network',
          ),
        ),
      );
    });
  });

  group('Save Watchlist', () {
    test('should return success message when saving successful', () async {
      when(mockLocalDataSource.insertWatchlistTv(testTvTable)).thenAnswer(
        (_) async => 'Added to Watchlist',
      );

      final result = await repository.saveWatchlistTv(testTvDetail);

      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockLocalDataSource.insertWatchlistTv(testTvTable)).thenThrow(
        DatabaseException(
          'Failed to add watchlist',
        ),
      );

      final result = await repository.saveWatchlistTv(testTvDetail);

      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when remove successful', () async {
      when(mockLocalDataSource.removeWatchlistTv(testTvTable)).thenAnswer(
        (_) async => 'Removed from watchlist',
      );

      final result = await repository.removeWatchlistTv(testTvDetail);

      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      when(mockLocalDataSource.removeWatchlistTv(testTvTable)).thenThrow(
        DatabaseException(
          'Failed to remove watchlist',
        ),
      );

      final result = await repository.removeWatchlistTv(testTvDetail);

      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get Watchlist Status', () {
    test('should return watch status whether data is found', () async {
      int id = 1;
      when(mockLocalDataSource.getTvById(id)).thenAnswer((_) async => null);

      final result = await repository.isAddedToWatchlistTv(id);

      expect(result, false);
    });
  });

  group('Get Watchlist Tv', () {
    test('should return list of Tv', () async {
      when(mockLocalDataSource.getWatchlistTv()).thenAnswer(
        (_) async => [testTvTable],
      );

      final result = await repository.getWatchlistTv();

      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
