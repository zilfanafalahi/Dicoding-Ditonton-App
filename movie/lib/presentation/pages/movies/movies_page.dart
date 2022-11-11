import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:movie/domain/entities/movies/movies.dart';
import 'package:movie/presentation/bloc/movies/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movie/presentation/bloc/movies/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/bloc/movies/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/movies/movie_detail_page.dart';
import 'package:movie/presentation/pages/movies/popular_movies_page.dart';
import 'package:movie/presentation/pages/movies/search_delegate_movies_page.dart';
import 'package:movie/presentation/pages/movies/top_rated_movies_page.dart';

class MoviesPage extends StatelessWidget {
  static const routeName = '/movies_page';

  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(
      () {
        context.read<NowPlayingMoviesBloc>().add(NowPlayingMoviesStarted());
        context.read<PopularMoviesBloc>().add(PopularMoviesStarted());
        context.read<TopRatedMoviesBloc>().add(TopRatedMoviesStarted());
      },
    );

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
          child: BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
            builder: (context, state) {
              if (state is NowPlayingMoviesLoaded) {
                return _nowPlayingLoaded(
                  context,
                  nowPlayingMovies: state.result,
                );
              }

              if (state is NowPlayingMoviesError) {
                return ErrorCustomWidget(message: state.message);
              }

              if (state is NowPlayingMoviesLoading) {
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
          child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            builder: (context, state) {
              if (state is PopularMoviesLoaded) {
                return _popularLoaded(
                  context,
                  popularMovies: state.result,
                );
              }

              if (state is PopularMoviesError) {
                return ErrorCustomWidget(message: state.message);
              }

              if (state is PopularMoviesLoading) {
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
          child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
            builder: (context, state) {
              if (state is TopRatedMoviesLoaded) {
                return _topRatedLoaded(
                  context,
                  topRatedMovies: state.result,
                );
              }

              if (state is TopRatedMoviesError) {
                return ErrorCustomWidget(message: state.message);
              }

              if (state is TopRatedMoviesLoading) {
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
