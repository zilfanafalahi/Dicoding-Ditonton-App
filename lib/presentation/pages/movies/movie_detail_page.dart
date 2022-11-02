import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/common/show_duration.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies_detail.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/movies_detail_provider.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_recommendation_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/data_not_available_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/error_custom_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/loading_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class MovieDetailPage extends StatelessWidget {
  static const routeName = '/movie_detail_page';

  final int id;

  const MovieDetailPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      Provider.of<MoviesDetailProvider>(context, listen: false)
          .fetchMovieDetail(id);
      Provider.of<MoviesDetailProvider>(context, listen: false)
          .loadWatchlistStatusMovie(id);
    });

    return Scaffold(
      body: Consumer<MoviesDetailProvider>(
        builder: (context, provider, widget) {
          final state = provider.movieState;

          if (state == ResultState.loaded) {
            return _moviesDetailLoaded(
              context,
              movie: provider.movie,
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
      ),
    );
  }

  Widget _moviesDetailLoaded(
    BuildContext context, {
    required MoviesDetail movie,
  }) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  movie.posterPath.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          height: 420,
                          color: kPrimaryColor,
                          child: CachedNetworkImage(
                            imageUrl: "$baseImageUrl${movie.posterPath}",
                            placeholder: (context, url) {
                              return const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: kWhiteColor,
                                    strokeWidth: 2.0,
                                  ),
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Padding(
                                padding: const EdgeInsets.all(42),
                                child: Image.asset(
                                  "assets/circle-g.png",
                                ),
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 420,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: kPrimaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(42),
                            child: Image.asset(
                              "assets/circle-g.png",
                            ),
                          ),
                        ),
                  Container(
                    width: double.infinity,
                    height: 420,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          kWhiteColor,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    child: Column(
                      children: [
                        Text(
                          movie.releaseDate.split("-")[0],
                          style: kTextTheme.subtitle2!.apply(
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          movie.title,
                          style: kTextTheme.subtitle1!.apply(
                            color: kPrimaryColor,
                            fontWeightDelta: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        RatingBarIndicator(
                          rating: movie.voteAverage / 2,
                          itemCount: 5,
                          itemBuilder: (context, index) => const Icon(
                            IconlyBold.star,
                            color: kPrimaryColor,
                          ),
                          itemSize: 16,
                          unratedColor: kGreyColor,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          showDuration(movie.runtime),
                          style: kTextTheme.subtitle2!.apply(
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: movie.genres.map((e) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: kPrimaryColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          child: Text(
                            e.name,
                            style: kTextTheme.overline!.apply(
                              color: kWhiteColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Overview",
                      style: kTextTheme.subtitle1!.apply(
                        color: kPrimaryColor,
                        fontWeightDelta: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    movie.overview.isNotEmpty
                        ? ReadMoreText(
                            movie.overview,
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'show more',
                            trimExpandedText: 'show less',
                            style: kTextTheme.bodyText2!.copyWith(
                              color: kPrimaryColor,
                            ),
                            moreStyle: kTextTheme.bodyText2!.copyWith(
                              color: kSecondaryColor,
                            ),
                            lessStyle: kTextTheme.bodyText2!.copyWith(
                              color: kSecondaryColor,
                            ),
                          )
                        : const DataNotAvailableWidet(),
                  ],
                ),
              ),
              _recommendations(context)
            ],
          ),
        ),
        _leading(context),
        _action(),
      ],
    );
  }

  Widget _recommendations(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Recommendations",
              style: kTextTheme.subtitle1!.apply(
                color: kPrimaryColor,
                fontWeightDelta: 2,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Consumer<MoviesDetailProvider>(
            builder: (context, provider, widget) {
              final state = provider.movieRecommendationState;

              if (state == ResultState.loaded) {
                return _recommendationLoaded(
                  context,
                  movieRecommendations: provider.movieRecommendations,
                );
              }

              if (state == ResultState.error) {
                return ErrorCustomWidget(
                    key: const Key('error_message_recommendation'),
                    message: provider.message);
              }

              if (state == ResultState.loading) {
                return const LoadingCustomWidget();
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _recommendationLoaded(
    BuildContext context, {
    required List<Movies> movieRecommendations,
  }) {
    return movieRecommendations.isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: movieRecommendations.map((e) {
                int index = movieRecommendations.indexOf(e);
                int indexLength = movieRecommendations.length;

                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 16 : 0,
                    right: index == (indexLength - 1) ? 16 : 8,
                  ),
                  child: CardRecommendationWidget(
                    id: e.id,
                    backdropPath: e.backdropPath,
                    title: e.title,
                    voteAverage: e.voteAverage,
                    releaseDate: e.releaseDate,
                    onTap: () {
                      Navigator.popAndPushNamed(
                        context,
                        MovieDetailPage.routeName,
                        arguments: e.id,
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          )
        : const DataNotAvailableWidet();
  }

  Widget _leading(BuildContext context) {
    return Positioned(
      top: 32,
      left: 16,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: ClipOval(
          child: Container(
            width: 42,
            height: 42,
            color: kWhiteColor,
            child: const Icon(
              IconlyLight.arrow_left,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _action() {
    return Positioned(
      top: 32,
      right: 16,
      child: Consumer<MoviesDetailProvider>(
        builder: (context, provider, widget) {
          return provider.isAddedToWatchlist
              ? InkWell(
                  onTap: () async {
                    await Provider.of<MoviesDetailProvider>(
                      context,
                      listen: false,
                    ).removeFromWatchlistMovie(provider.movie).then((value) {
                      final message = Provider.of<MoviesDetailProvider>(
                        context,
                        listen: false,
                      ).watchlistMessage;

                      if (message ==
                              MoviesDetailProvider.watchlistAddSuccessMessage ||
                          message ==
                              MoviesDetailProvider
                                  .watchlistRemoveSuccessMessage) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: kPrimaryColor,
                            content: Text(
                              message,
                              style: kTextTheme.caption!.apply(
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                "Failed",
                                style: kTextTheme.caption!.apply(
                                  color: kRedColor,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }).catchError((error, stackTrace) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                              "Failed",
                              style: kTextTheme.caption!.apply(
                                color: kRedColor,
                              ),
                            ),
                          );
                        },
                      );
                    });
                  },
                  child: ClipOval(
                    child: Container(
                      width: 42,
                      height: 42,
                      color: kWhiteColor,
                      child: const Icon(
                        IconlyBold.bookmark,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                )
              : InkWell(
                  key: const Key("inkwell_add_watchlist_key"),
                  onTap: () async {
                    await Provider.of<MoviesDetailProvider>(
                      context,
                      listen: false,
                    ).addWatchlistMovie(provider.movie).then((value) {
                      final message = Provider.of<MoviesDetailProvider>(
                        context,
                        listen: false,
                      ).watchlistMessage;

                      if (message ==
                              MoviesDetailProvider.watchlistAddSuccessMessage ||
                          message ==
                              MoviesDetailProvider
                                  .watchlistRemoveSuccessMessage) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: kPrimaryColor,
                            content: Text(
                              message,
                              style: kTextTheme.caption!.apply(
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                "Failed",
                                style: kTextTheme.caption!.apply(
                                  color: kRedColor,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }).catchError((error, stackTrace) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                              "Failed",
                              style: kTextTheme.caption!.apply(
                                color: kRedColor,
                              ),
                            ),
                          );
                        },
                      );
                    });
                  },
                  child: ClipOval(
                    child: Container(
                      width: 42,
                      height: 42,
                      color: kWhiteColor,
                      child: const Icon(
                        IconlyLight.bookmark,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
