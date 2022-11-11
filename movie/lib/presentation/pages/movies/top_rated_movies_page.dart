import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movies/movies.dart';
import 'package:movie/presentation/bloc/movies/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/movies/movie_detail_page.dart';

class TopRatedMoviesPage extends StatelessWidget {
  static const routeName = '/top_rated_movies_page';

  const TopRatedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(
      () => context.read<TopRatedMoviesBloc>().add(TopRatedMoviesStarted()),
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
        "Top Rated Movies",
        style: kTextTheme.headline6!.apply(
          color: kWhiteColor,
        ),
      ),
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
      builder: (context, state) {
        if (state is TopRatedMoviesLoaded) {
          return _topRatedLoaded(
            context,
            movies: state.result,
          );
        }

        if (state is TopRatedMoviesError) {
          return ErrorCustomWidget(
            key: const Key('error_message'),
            message: state.message,
          );
        }

        if (state is TopRatedMoviesLoading) {
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
