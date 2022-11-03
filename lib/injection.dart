import 'package:dicoding_ditonton_app/common/ssl_pinning.dart';
import 'package:dicoding_ditonton_app/data/datasources/db/db_helper.dart';
import 'package:dicoding_ditonton_app/data/datasources/movies/movies_local_data_source.dart';
import 'package:dicoding_ditonton_app/data/datasources/movies/movies_remote_data_source.dart';
import 'package:dicoding_ditonton_app/data/datasources/tv/tv_local_data_source.dart';
import 'package:dicoding_ditonton_app/data/datasources/tv/tv_remote_data_source.dart';
import 'package:dicoding_ditonton_app/data/repositories/movies_repository_impl.dart';
import 'package:dicoding_ditonton_app/data/repositories/tv_repository_impl.dart';
import 'package:dicoding_ditonton_app/domain/repositories/movies_repository.dart';
import 'package:dicoding_ditonton_app/domain/repositories/tv_repository.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_movie_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_popular_movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_watchlist_status_movie.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/remove_watchlist_movie.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/save_watchlist_movie.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/search_movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_on_the_air_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_popular_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_season_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/search_tv.dart';
import 'package:dicoding_ditonton_app/presentation/provider/bottom_navigation_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/movies_detail_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/movies_list_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/movies_search_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/popular_movies_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/top_rated_movies_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/watchlist_movies_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/popular_tv_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/top_rated_tv_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/tv_detail_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/tv_list_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/tv_search_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/tv_season_detail_provider.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/watchlist_tv_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory(
    () => MoviesListProvider(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesDetailProvider(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatusMovie: locator(),
      saveWatchlistMovie: locator(),
      removeWatchlistMovie: locator(),
    ),
  );
  locator.registerFactory(
    () => MoviesSearchProvider(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesProvider(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesProvider(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesProvider(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => BottomNavigationProvider(),
  );
  locator.registerFactory(
    () => TvListProvider(
      getOnTheAirTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailProvider(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatusTv: locator(),
      saveWatchlistTv: locator(),
      removeWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchProvider(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvProvider(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvProvider(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvProvider(
      getWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeasonDetailProvider(
      getTvSeasonDetail: locator(),
    ),
  );

  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetTvSeasonDetail(locator()));

  locator.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<MoviesLocalDataSource>(
      () => MoviesLocalDataSourceImpl(dbHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(dbHelper: locator()));

  locator.registerLazySingleton<DbHelper>(() => DbHelper());

  IOClient ioClient = await SSLPinning().ioClient;
  locator.registerLazySingleton<IOClient>(() => ioClient);
}
