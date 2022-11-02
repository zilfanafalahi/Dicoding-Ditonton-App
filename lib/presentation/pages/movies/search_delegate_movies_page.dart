import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/presentation/pages/movies/movie_detail_page.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/movies_search_provider.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_grid_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/error_custom_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/loading_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class SearchDelegateMoviesPage extends SearchDelegate<String> {
  SearchDelegateMoviesPage({
    required BuildContext context,
  }) : super(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          searchFieldDecorationTheme: InputDecorationTheme(
            hintStyle: kTextTheme.bodyText1!.apply(
              color: kWhiteColor.withOpacity(0.1),
            ),
            labelStyle: kTextTheme.bodyText1!.apply(
              color: kWhiteColor,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: kPrimaryColor,
                width: 0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: kPrimaryColor,
                width: 0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: kPrimaryColor,
                width: 0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
          ),
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final superThemeData = super.appBarTheme(context);
    return superThemeData.copyWith(
      textTheme: superThemeData.textTheme.copyWith(
        headline6: kTextTheme.bodyText1!.apply(
          color: kWhiteColor,
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kWhiteColor,
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          IconlyLight.arrow_left,
          color: kWhiteColor,
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            IconlyLight.search,
            color: kPrimaryColor,
            size: 42,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Search movies by title",
            style: kTextTheme.bodyText1!.apply(
              color: kPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.microtask(() =>
        Provider.of<MoviesSearchProvider>(context, listen: false)
            .fetchMovieSearch(query));

    return Consumer<MoviesSearchProvider>(
      builder: (context, provider, widget) {
        if (provider.state == ResultState.loaded) {
          return _results(context);
        }

        if (provider.state == ResultState.error) {
          return ErrorCustomWidget(message: provider.message);
        }

        if (provider.state == ResultState.loading) {
          return const LoadingCustomWidget();
        }

        return const SizedBox();
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
        GestureDetector(
          onTap: () {
            query = "";
            showSuggestions(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              IconlyLight.close_square,
              color: kWhiteColor,
            ),
          ),
        )
      ];

  Widget _results(BuildContext context) {
    return Consumer<MoviesSearchProvider>(
      builder: (context, provider, widget) {
        final state = provider.state;

        if (state == ResultState.loaded) {
          return _searchLoaded(
            context,
            searchResultMovies: provider.searchResultMovies,
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
    );
  }

  Widget _searchLoaded(
    BuildContext context, {
    required List<Movies> searchResultMovies,
  }) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 283,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: searchResultMovies.length,
      itemBuilder: (BuildContext context, index) {
        return CardGridWidget(
          id: searchResultMovies[index].id,
          posterPath: searchResultMovies[index].posterPath,
          title: searchResultMovies[index].title,
          voteAverage: searchResultMovies[index].voteAverage,
          releaseDate: searchResultMovies[index].releaseDate,
          onTap: () {
            Navigator.pushNamed(
              context,
              MovieDetailPage.routeName,
              arguments: searchResultMovies[index].id,
            );
          },
        );
      },
    );
  }
}
