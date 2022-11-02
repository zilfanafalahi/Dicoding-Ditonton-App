import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/common/show_duration.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv_detail.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/tv_season_detail_page.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/tv_detail_provider.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_recommendation_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_season_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/data_not_available_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/error_custom_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/loading_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class TvDetailPage extends StatelessWidget {
  static const routeName = '/tv_detail_page';

  final int id;

  const TvDetailPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      Provider.of<TvDetailProvider>(context, listen: false).fetchTvDetail(id);
      Provider.of<TvDetailProvider>(context, listen: false)
          .loadWatchlistStatusTv(id);
    });

    return Scaffold(
      body: Consumer<TvDetailProvider>(
        builder: (context, provider, widget) {
          final state = provider.tvState;

          if (state == ResultState.loaded) {
            return _tvDetailLoaded(
              context,
              tvDetail: provider.tv,
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

  Widget _tvDetailLoaded(
    BuildContext context, {
    required TvDetail tvDetail,
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
                  tvDetail.posterPath.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          height: 420,
                          color: kPrimaryColor,
                          child: CachedNetworkImage(
                            imageUrl: "$baseImageUrl${tvDetail.posterPath}",
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
                          tvDetail.firstAirDate.split("-")[0],
                          style: kTextTheme.subtitle2!.apply(
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          tvDetail.name,
                          style: kTextTheme.subtitle1!.apply(
                            color: kPrimaryColor,
                            fontWeightDelta: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        RatingBarIndicator(
                          rating: tvDetail.voteAverage / 2,
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
                          showDuration(tvDetail.episodeRunTime.isNotEmpty
                              ? tvDetail.episodeRunTime[0]
                              : 0),
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
                      children: tvDetail.genres.map((e) {
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
                    tvDetail.overview.isNotEmpty
                        ? ReadMoreText(
                            tvDetail.overview,
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
              _seasons(context),
              _recommendations(context),
            ],
          ),
        ),
        _leading(context),
        _action(),
      ],
    );
  }

  Widget _seasons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              "Seasons",
              style: kTextTheme.subtitle1!.apply(
                color: kPrimaryColor,
                fontWeightDelta: 2,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Consumer<TvDetailProvider>(
            builder: (context, provider, widget) {
              final state = provider.tvState;

              if (state == ResultState.loaded) {
                return _seasonLoaded(
                  context,
                  tvDetail: provider.tv,
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
        ],
      ),
    );
  }

  Widget _seasonLoaded(
    BuildContext context, {
    required TvDetail tvDetail,
  }) {
    return tvDetail.seasons.isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tvDetail.seasons.map((e) {
                int index = tvDetail.seasons.indexOf(e);
                int indexLength = tvDetail.seasons.length;

                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 16 : 0,
                    right: index == (indexLength - 1) ? 16 : 8,
                  ),
                  child: CardSeasonWidget(
                    id: e.id,
                    posterPath: e.posterPath,
                    name: e.name,
                    episodeCount: e.episodeCount,
                    airDate: e.airDate,
                    seasonNumber: e.seasonNumber,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        TvSeasonDetailPage.routeName,
                        arguments: TvSeasonDetailPageArgs(
                          name: e.name,
                          id: id,
                          seasonNumber: e.seasonNumber,
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          )
        : const DataNotAvailableWidet();
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
          Consumer<TvDetailProvider>(
            builder: (context, provider, widget) {
              final state = provider.tvRecommendationState;

              if (state == ResultState.loaded) {
                return _recommendationLoaded(
                  context,
                  tvRecommendations: provider.tvRecommendations,
                );
              }

              if (state == ResultState.error) {
                return ErrorCustomWidget(
                  message: provider.message,
                );
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
    required List<Tv> tvRecommendations,
  }) {
    return tvRecommendations.isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tvRecommendations.map((e) {
                int index = tvRecommendations.indexOf(e);
                int indexLength = tvRecommendations.length;

                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 16 : 0,
                    right: index == (indexLength - 1) ? 16 : 8,
                  ),
                  child: CardRecommendationWidget(
                    id: e.id,
                    backdropPath: e.backdropPath,
                    title: e.name,
                    voteAverage: e.voteAverage,
                    releaseDate: e.firstAirDate,
                    onTap: () {
                      Navigator.popAndPushNamed(
                        context,
                        TvDetailPage.routeName,
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
      child: Consumer<TvDetailProvider>(
        builder: (context, provider, widget) {
          return provider.isAddedToWatchlist
              ? InkWell(
                  onTap: () async {
                    await Provider.of<TvDetailProvider>(
                      context,
                      listen: false,
                    ).removeFromWatchlistTv(provider.tv).then((value) {
                      final message = Provider.of<TvDetailProvider>(
                        context,
                        listen: false,
                      ).watchlistMessage;

                      if (message ==
                              TvDetailProvider.watchlistAddSuccessMessage ||
                          message ==
                              TvDetailProvider.watchlistRemoveSuccessMessage) {
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
                    await Provider.of<TvDetailProvider>(
                      context,
                      listen: false,
                    ).addWatchlistTv(provider.tv).then((value) {
                      final message = Provider.of<TvDetailProvider>(
                        context,
                        listen: false,
                      ).watchlistMessage;

                      if (message ==
                              TvDetailProvider.watchlistAddSuccessMessage ||
                          message ==
                              TvDetailProvider.watchlistRemoveSuccessMessage) {
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
