import 'package:dicoding_ditonton_app/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/detail_movies/detail_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/popular_movies/popular_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/watchlist_status_movies/watchlist_status_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/detail_tv/detail_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/on_the_air_tv/on_the_air_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/recommendation_tv/recommendation_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/search_tv/search_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/season_detail_tv/season_detail_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/watchlist_status_tv/watchlist_status_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:dicoding_ditonton_app/injection.dart' as di;

import 'presentation/bloc/movies/search_movies/search_movies_bloc.dart';

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
  BlocProvider<NowPlayingMoviesBloc>(
    create: (_) => di.locator<NowPlayingMoviesBloc>(),
  ),
  BlocProvider<PopularMoviesBloc>(
    create: (_) => di.locator<PopularMoviesBloc>(),
  ),
  BlocProvider<TopRatedMoviesBloc>(
    create: (_) => di.locator<TopRatedMoviesBloc>(),
  ),
  BlocProvider<SearchMoviesBloc>(
    create: (_) => di.locator<SearchMoviesBloc>(),
  ),
  BlocProvider<DetailMoviesBloc>(
    create: (_) => di.locator<DetailMoviesBloc>(),
  ),
  BlocProvider<RecommendationMoviesBloc>(
    create: (_) => di.locator<RecommendationMoviesBloc>(),
  ),
  BlocProvider<WatchlistStatusMoviesBloc>(
    create: (_) => di.locator<WatchlistStatusMoviesBloc>(),
  ),
  BlocProvider<WatchlistMoviesBloc>(
    create: (_) => di.locator<WatchlistMoviesBloc>(),
  ),
  BlocProvider<OnTheAirTvBloc>(
    create: (_) => di.locator<OnTheAirTvBloc>(),
  ),
  BlocProvider<PopularTvBloc>(
    create: (_) => di.locator<PopularTvBloc>(),
  ),
  BlocProvider<TopRatedTvBloc>(
    create: (_) => di.locator<TopRatedTvBloc>(),
  ),
  BlocProvider<SearchTvBloc>(
    create: (_) => di.locator<SearchTvBloc>(),
  ),
  BlocProvider<DetailTvBloc>(
    create: (_) => di.locator<DetailTvBloc>(),
  ),
  BlocProvider<SeasonDetailTvBloc>(
    create: (_) => di.locator<SeasonDetailTvBloc>(),
  ),
  BlocProvider<RecommendationTvBloc>(
    create: (_) => di.locator<RecommendationTvBloc>(),
  ),
  BlocProvider<WatchlistStatusTvBloc>(
    create: (_) => di.locator<WatchlistStatusTvBloc>(),
  ),
  BlocProvider<WatchlistTvBloc>(
    create: (_) => di.locator<WatchlistTvBloc>(),
  ),
  BlocProvider<BottomNavigationBloc>(
    create: (_) => di.locator<BottomNavigationBloc>(),
  ),
];
