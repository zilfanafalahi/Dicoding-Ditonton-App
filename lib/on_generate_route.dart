import 'package:about/about_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/main_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

Route<dynamic>? Function(RouteSettings)? onGenerateRoute =
    (RouteSettings settings) {
  switch (settings.name) {
    case MainPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const MainPage(),
      );
    case MoviesPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const MoviesPage(),
      );
    case PopularMoviesPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const PopularMoviesPage(),
      );
    case TopRatedMoviesPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const TopRatedMoviesPage(),
      );
    case MovieDetailPage.routeName:
      final id = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => MovieDetailPage(id: id),
        settings: settings,
      );
    case TvPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const TvPage(),
      );
    case PopularTvPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const PopularTvPage(),
      );
    case TopRatedTvPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const TopRatedTvPage(),
      );
    case TvDetailPage.routeName:
      final id = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => TvDetailPage(id: id),
        settings: settings,
      );
    case TvSeasonDetailPage.routeName:
      final args = settings.arguments as TvSeasonDetailPageArgs;
      return MaterialPageRoute(
        builder: (_) => TvSeasonDetailPage(
          args: args,
        ),
        settings: settings,
      );
    case AboutPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const AboutPage(),
      );
    case WatchlistPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const WatchlistPage(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        },
      );
  }
};
