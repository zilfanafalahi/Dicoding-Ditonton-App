import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/presentation/pages/movies/movie_detail_page.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/top_rated_movies_provider.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_grid_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/error_custom_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/loading_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedMoviesPage extends StatelessWidget {
  static const routeName = '/top_rated_movies_page';

  const TopRatedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() =>
        Provider.of<TopRatedMoviesProvider>(context, listen: false)
            .fetchTopRatedMovies());

    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Text(
        "Top Rated Movies",
        style: kTextTheme.headline6!.apply(
          color: kWhiteColor,
        ),
      ),
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    return Consumer<TopRatedMoviesProvider>(
      builder: (context, provider, widget) {
        final state = provider.state;

        if (state == ResultState.loaded) {
          return _topRatedLoaded(
            context,
            movies: provider.movies,
          );
        }

        if (state == ResultState.error) {
          return ErrorCustomWidget(
            key: const Key('error_message'),
            message: provider.message,
          );
        }

        if (state == ResultState.loading) {
          return const LoadingCustomWidget();
        }

        return const SizedBox();
      },
    );
  }

  Widget _topRatedLoaded(
    BuildContext context, {
    required List<Movies> movies,
  }) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 283,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: movies.length,
      itemBuilder: (BuildContext context, index) {
        return CardGridWidget(
          id: movies[index].id,
          posterPath: movies[index].posterPath,
          title: movies[index].title,
          voteAverage: movies[index].voteAverage,
          releaseDate: movies[index].releaseDate,
          onTap: () {
            Navigator.pushNamed(
              context,
              MovieDetailPage.routeName,
              arguments: movies[index].id,
            );
          },
        );
      },
    );
  }
}
