import 'package:dicoding_ditonton_app/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/detail_movies/detail_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/popular_movies/popular_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/search_movies/search_movies_bloc.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:dicoding_ditonton_app/injection.dart' as di;

List<SingleChildWidget> listBlocs = [
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
