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
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:dicoding_ditonton_app/injection.dart' as di;

List<SingleChildWidget> listProviders = [
  ChangeNotifierProvider(
    create: (_) => di.locator<MoviesListProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<MoviesDetailProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<MoviesSearchProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<TopRatedMoviesProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<PopularMoviesProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<WatchlistMoviesProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<BottomNavigationProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<TvListProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<TvDetailProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<TvSearchProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<TopRatedTvProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<PopularTvProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<WatchlistTvProvider>(),
  ),
  ChangeNotifierProvider(
    create: (_) => di.locator<TvSeasonDetailProvider>(),
  ),
];
