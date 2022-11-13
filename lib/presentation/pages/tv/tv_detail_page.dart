import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/show_duration.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv_detail.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/detail_tv/detail_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/recommendation_tv/recommendation_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/watchlist_status_tv/watchlist_status_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/tv_season_detail_page.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_recommendation_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_season_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/data_not_available_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/error_custom_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/loading_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconly/iconly.dart';
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
    Future.microtask(
      () {
        context.read<DetailTvBloc>().add(
              DetailTvStarted(id: id),
            );
        context.read<RecommendationTvBloc>().add(
              RecommendationTvStarted(id: id),
            );
        context.read<WatchlistStatusTvBloc>().add(
              WatchlistStatusTvtarted(id: id),
            );
      },
    );

    return Scaffold(
      body: BlocBuilder<DetailTvBloc, DetailTvState>(
        builder: (context, state) {
          if (state is DetailTvLoaded) {
            return _tvDetailLoaded(
              context,
              detailTv: state.result,
            );
          }

          if (state is DetailTvError) {
            return ErrorCustomWidget(
              key: const Key('error_message'),
              message: state.message,
            );
          }

          if (state is DetailTvLoading) {
            return const LoadingCustomWidget();
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _tvDetailLoaded(
    BuildContext context, {
    required TvDetail detailTv,
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
                  detailTv.posterPath.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          height: 420,
                          color: kPrimaryColor,
                          child: CachedNetworkImage(
                            imageUrl: "$baseImageUrl${detailTv.posterPath}",
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
                          detailTv.firstAirDate.split("-")[0],
                          style: kTextTheme.subtitle2!.apply(
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          detailTv.name,
                          style: kTextTheme.subtitle1!.apply(
                            color: kPrimaryColor,
                            fontWeightDelta: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        RatingBarIndicator(
                          rating: detailTv.voteAverage / 2,
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
                          showDuration(detailTv.episodeRunTime.isNotEmpty
                              ? detailTv.episodeRunTime[0]
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
                      children: detailTv.genres.map((e) {
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
                    detailTv.overview.isNotEmpty
                        ? ReadMoreText(
                            detailTv.overview,
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
              _seasons(context, detailTv: detailTv),
              _recommendations(context),
            ],
          ),
        ),
        _leading(context),
        _action(context, detailTv: detailTv),
      ],
    );
  }

  Widget _seasons(
    BuildContext context, {
    required TvDetail detailTv,
  }) {
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
          _seasonLoaded(
            context,
            detailTv: detailTv,
          ),
        ],
      ),
    );
  }

  Widget _seasonLoaded(
    BuildContext context, {
    required TvDetail detailTv,
  }) {
    return detailTv.seasons.isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: detailTv.seasons.map((e) {
                int index = detailTv.seasons.indexOf(e);
                int indexLength = detailTv.seasons.length;

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
          BlocBuilder<RecommendationTvBloc, RecommendationTvState>(
            builder: (context, state) {
              if (state is RecommendationTvLoaded) {
                return _recommendationLoaded(
                  context,
                  tvRecommendations: state.result,
                );
              }

              if (state is RecommendationTvError) {
                return ErrorCustomWidget(
                  message: state.message,
                );
              }

              if (state is RecommendationTvLoading) {
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

  Widget _action(
    BuildContext context, {
    required TvDetail detailTv,
  }) {
    bool isSave = (context.watch<WatchlistStatusTvBloc>().state
            is IsSaveWatchlistStatusTv)
        ? (context.read<WatchlistStatusTvBloc>().state
                as IsSaveWatchlistStatusTv)
            .isSave
        : false;

    return BlocListener<WatchlistStatusTvBloc, WatchlistStatusTvState>(
      listener: (context, state) {
        if (state is SaveWatchlistStatusTvMessage) {
          final message = state.message;

          if (message == WatchlistStatusTvBloc.watchlistAddSuccessMessage ||
              message == WatchlistStatusTvBloc.watchlistRemoveSuccessMessage) {
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
        }

        if (state is RemoveWatchlistStatusTvMessage) {
          final message = state.message;

          if (message == WatchlistStatusTvBloc.watchlistAddSuccessMessage ||
              message == WatchlistStatusTvBloc.watchlistRemoveSuccessMessage) {
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
        }
      },
      child: Positioned(
        top: 32,
        right: 16,
        child: isSave
            ? InkWell(
                onTap: () {
                  context.read<WatchlistStatusTvBloc>().add(
                        RemoveWatchlistStatusTvStarted(
                          detailTv: detailTv,
                        ),
                      );
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
                onTap: () {
                  context.read<WatchlistStatusTvBloc>().add(
                        SaveWatchlistStatusTvStarted(
                          detailTv: detailTv,
                        ),
                      );
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
              ),
      ),
    );
  }
}
