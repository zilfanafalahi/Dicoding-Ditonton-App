import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_movie_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_watchlist_status_movie.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/remove_watchlist_movie.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/save_watchlist_movie.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/movies_detail_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movies/dummy_objects_movies.dart';
import 'movies_detail_provider_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatusMovie,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
])
void main() {
  late MoviesDetailProvider provider;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatusMovie mockGetWatchlistStatus;
  late MockSaveWatchlistMovie mockSaveWatchlist;
  late MockRemoveWatchlistMovie mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatusMovie();
    mockSaveWatchlist = MockSaveWatchlistMovie();
    mockRemoveWatchlist = MockRemoveWatchlistMovie();
    provider = MoviesDetailProvider(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatusMovie: mockGetWatchlistStatus,
      saveWatchlistMovie: mockSaveWatchlist,
      removeWatchlistMovie: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  int id = 1;

  const tMovie = Movies(
    id: 1,
    backdropPath: "/backdrop_path.jpg",
    posterPath: "/poster_path.jpg",
    title: "Title",
    voteAverage: 8.5,
    releaseDate: "2022-10-25",
  );
  final tMovies = <Movies>[tMovie];

  void arrangeUsecase() {
    when(mockGetMovieDetail.execute(id)).thenAnswer(
      (_) async => const Right(testMoviesDetail),
    );
    when(mockGetMovieRecommendations.execute(id)).thenAnswer(
      (_) async => Right(tMovies),
    );
  }

  group('Get Movie Detail', () {
    test('should get data from the usecase', () async {
      arrangeUsecase();

      await provider.fetchMovieDetail(id);

      verify(mockGetMovieDetail.execute(id));
      verify(mockGetMovieRecommendations.execute(id));
    });

    test('should change state to Loading when usecase is called', () {
      arrangeUsecase();

      provider.fetchMovieDetail(id);

      expect(provider.movieState, ResultState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      arrangeUsecase();

      await provider.fetchMovieDetail(id);

      expect(provider.movieState, ResultState.loaded);
      expect(provider.movie, testMoviesDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      arrangeUsecase();

      await provider.fetchMovieDetail(id);

      expect(provider.movieState, ResultState.loaded);
      expect(provider.movieRecommendations, tMovies);
    });
  });

  group('Get Movie Recommendations', () {
    test('should get data from the usecase', () async {
      arrangeUsecase();

      await provider.fetchMovieDetail(id);

      verify(mockGetMovieRecommendations.execute(id));
      expect(provider.movieRecommendations, tMovies);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      arrangeUsecase();

      await provider.fetchMovieDetail(id);

      expect(provider.movieRecommendationState, ResultState.loaded);
      expect(provider.movieRecommendations, tMovies);
    });

    test('should update error message when request in successful', () async {
      when(mockGetMovieDetail.execute(id)).thenAnswer(
        (_) async => const Right(testMoviesDetail),
      );
      when(mockGetMovieRecommendations.execute(id)).thenAnswer(
        (_) async => const Left(ServerFailure('Failed')),
      );

      await provider.fetchMovieDetail(id);

      expect(provider.movieRecommendationState, ResultState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);

      await provider.loadWatchlistStatusMovie(1);

      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      when(mockSaveWatchlist.execute(testMoviesDetail)).thenAnswer(
        (_) async => const Right('Success'),
      );
      when(
        mockGetWatchlistStatus.execute(testMoviesDetail.id),
      ).thenAnswer((_) async => true);

      await provider.addWatchlistMovie(testMoviesDetail);

      verify(mockSaveWatchlist.execute(testMoviesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      when(mockRemoveWatchlist.execute(testMoviesDetail)).thenAnswer(
        (_) async => const Right('Removed'),
      );
      when(
        mockGetWatchlistStatus.execute(testMoviesDetail.id),
      ).thenAnswer((_) async => false);

      await provider.removeFromWatchlistMovie(testMoviesDetail);

      verify(mockRemoveWatchlist.execute(testMoviesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      when(mockSaveWatchlist.execute(testMoviesDetail)).thenAnswer(
        (_) async => const Right('Added to Watchlist'),
      );
      when(
        mockGetWatchlistStatus.execute(testMoviesDetail.id),
      ).thenAnswer((_) async => true);

      await provider.addWatchlistMovie(testMoviesDetail);

      verify(mockGetWatchlistStatus.execute(testMoviesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      when(mockSaveWatchlist.execute(testMoviesDetail)).thenAnswer(
        (_) async => const Left(DatabaseFailure('Failed')),
      );
      when(mockGetWatchlistStatus.execute(testMoviesDetail.id)).thenAnswer(
        (_) async => false,
      );

      await provider.addWatchlistMovie(testMoviesDetail);

      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('On Error', () {
    test('should return error when data is unsuccessful', () async {
      when(mockGetMovieDetail.execute(id)).thenAnswer(
        (_) async => const Left(
          ServerFailure('Server Failure'),
        ),
      );
      when(mockGetMovieRecommendations.execute(id)).thenAnswer(
        (_) async => Right(tMovies),
      );

      await provider.fetchMovieDetail(id);

      expect(provider.movieState, ResultState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
