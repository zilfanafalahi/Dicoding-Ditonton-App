import 'package:dicoding_ditonton_app/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:provider/single_child_widget.dart';
import 'package:dicoding_ditonton_app/injection.dart' as di;
import 'package:tv/tv.dart';

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
