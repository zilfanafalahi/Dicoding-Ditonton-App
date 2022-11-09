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
import 'package:dicoding_ditonton_app/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/detail_movies/detail_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/popular_movies/popular_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/search_movies/search_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/detail_tv/detail_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/on_the_air_tv/on_the_air_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/recommendation_tv/recommendation_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/search_tv/search_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/season_detail_tv/season_detail_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/watchlist_status_tv/watchlist_status_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

import 'presentation/bloc/movies/watchlist_status_movies/watchlist_status_movies_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      getNowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMoviesBloc(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailMoviesBloc(
      getMovieDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationMoviesBloc(
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistStatusMoviesBloc(
      getWatchListStatusMovie: locator(),
      saveWatchlistMovie: locator(),
      removeWatchlistMovie: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirTvBloc(
      getOnTheAirTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvBloc(
      getPopularTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvBloc(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => DetailTvBloc(
      getTvDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => SeasonDetailTvBloc(
      getTvSeasonDetail: locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationTvBloc(
      getTvRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistStatusTvBloc(
      getWatchListStatusTv: locator(),
      saveWatchlistTv: locator(),
      removeWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(
      getWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => BottomNavigationBloc(),
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
