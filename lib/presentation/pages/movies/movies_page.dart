import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/presentation/pages/movies/movie_detail_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/movies/popular_movies_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/movies/search_delegate_movies_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/movies_list_provider.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_list_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/error_custom_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/loading_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class MoviesPage extends StatelessWidget {
  static const routeName = '/movies_page';

  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(
        () => Provider.of<MoviesListProvider>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());

    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Text(
        "Movies",
        style: kTextTheme.headline6!.apply(
          color: kWhiteColor,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            showSearch(
              context: context,
              delegate: SearchDelegateMoviesPage(context: context),
            );
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              IconlyLight.search,
              color: kWhiteColor,
            ),
          ),
        ),
      ],
      automaticallyImplyLeading: false,
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nowPlaying(context),
          _popular(context),
          _topRated(context),
        ],
      ),
    );
  }

  Widget _nowPlaying(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            "Now Playing",
            style: kTextTheme.subtitle1!.apply(
              color: kPrimaryColor,
              fontWeightDelta: 2,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Consumer<MoviesListProvider>(
            builder: (context, provider, widget) {
              final state = provider.nowPlayingState;

              if (state == ResultState.loaded) {
                return _nowPlayingLoaded(
                  context,
                  nowPlayingMovies: provider.nowPlayingMovies,
                );
              }

              if (state == ResultState.error) {
                return ErrorCustomWidget(message: provider.message);
              }

              if (state == ResultState.loading) {
                return const LoadingCustomWidget();
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _nowPlayingLoaded(
    BuildContext context, {
    required List<Movies> nowPlayingMovies,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: nowPlayingMovies.map((e) {
          int index = nowPlayingMovies.indexOf(e);
          int indexLength = nowPlayingMovies.length;

          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 0,
              right: index == (indexLength - 1) ? 16 : 8,
            ),
            child: CardListWidget(
              id: e.id,
              posterPath: e.posterPath,
              title: e.title,
              voteAverage: e.voteAverage,
              releaseDate: e.releaseDate,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: e.id,
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _popular(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular",
                style: kTextTheme.subtitle1!.apply(
                  color: kPrimaryColor,
                  fontWeightDelta: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PopularMoviesPage.routeName,
                  );
                },
                child: Text(
                  "See All",
                  style: kTextTheme.subtitle2!.apply(
                    color: kSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Consumer<MoviesListProvider>(
            builder: (context, provider, widget) {
              final state = provider.popularMoviesState;

              if (state == ResultState.loaded) {
                return _popularLoaded(
                  context,
                  popularMovies: provider.popularMovies,
                );
              }

              if (state == ResultState.error) {
                return ErrorCustomWidget(message: provider.message);
              }

              if (state == ResultState.loading) {
                return const LoadingCustomWidget();
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _popularLoaded(
    BuildContext context, {
    required List<Movies> popularMovies,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: popularMovies.map((e) {
          int index = popularMovies.indexOf(e);
          int indexLength = popularMovies.length;

          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 0,
              right: index == (indexLength - 1) ? 16 : 8,
            ),
            child: CardListWidget(
              id: e.id,
              posterPath: e.posterPath,
              title: e.title,
              voteAverage: e.voteAverage,
              releaseDate: e.releaseDate,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: e.id,
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _topRated(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Rated",
                style: kTextTheme.subtitle1!.apply(
                  color: kPrimaryColor,
                  fontWeightDelta: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TopRatedMoviesPage.routeName,
                  );
                },
                child: Text(
                  "See All",
                  style: kTextTheme.subtitle2!.apply(
                    color: kSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Consumer<MoviesListProvider>(
            builder: (context, provider, widget) {
              final state = provider.topRatedMoviesState;

              if (state == ResultState.loaded) {
                return _topRatedLoaded(
                  context,
                  topRatedMovies: provider.topRatedMovies,
                );
              }

              if (state == ResultState.error) {
                return ErrorCustomWidget(message: provider.message);
              }

              if (state == ResultState.loading) {
                return const LoadingCustomWidget();
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _topRatedLoaded(
    BuildContext context, {
    required List<Movies> topRatedMovies,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: topRatedMovies.map((e) {
          int index = topRatedMovies.indexOf(e);
          int indexLength = topRatedMovies.length;

          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 0,
              right: index == (indexLength - 1) ? 16 : 8,
            ),
            child: CardListWidget(
              id: e.id,
              posterPath: e.posterPath,
              title: e.title,
              voteAverage: e.voteAverage,
              releaseDate: e.releaseDate,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: e.id,
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
