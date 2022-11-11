import 'package:common/common.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

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
      () => MoviesLocalDataSourceImpl(moviesDbHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(tvDbHelper: locator()));

  locator.registerLazySingleton<MoviesDbHelper>(() => MoviesDbHelper());
  locator.registerLazySingleton<TvDbHelper>(() => TvDbHelper());

  IOClient ioClient = await SSLPinning().ioClient;
  locator.registerLazySingleton<IOClient>(() => ioClient);
}
