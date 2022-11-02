import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/popular_tv_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/search_delegate_tv_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/tv_detail_page.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/tv_list_provider.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_list_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/error_custom_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/loading_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class TvPage extends StatelessWidget {
  static const routeName = '/tv_page';

  const TvPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => Provider.of<TvListProvider>(context, listen: false)
      ..fetchOnTheAirTv()
      ..fetchPopularTv()
      ..fetchTopRatedTv());

    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Text(
        "Tv Shows",
        style: kTextTheme.headline6!.apply(
          color: kWhiteColor,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            showSearch(
              context: context,
              delegate: SearchDelegateTvPage(context: context),
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
          _onTheAir(context),
          _popular(context),
          _topRated(context),
        ],
      ),
    );
  }

  Widget _onTheAir(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            "On The Air",
            style: kTextTheme.subtitle1!.apply(
              color: kPrimaryColor,
              fontWeightDelta: 2,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Consumer<TvListProvider>(
            builder: (context, provider, widget) {
              final state = provider.onTheAirState;

              if (state == ResultState.loaded) {
                return _onTheAirLoaded(
                  context,
                  onTheAirTv: provider.onTheAirTv,
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
        ),
      ],
    );
  }

  Widget _onTheAirLoaded(
    BuildContext context, {
    required List<Tv> onTheAirTv,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: onTheAirTv.map((e) {
          int index = onTheAirTv.indexOf(e);
          int indexLength = onTheAirTv.length;

          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 0,
              right: index == (indexLength - 1) ? 16 : 8,
            ),
            child: CardListWidget(
              id: e.id,
              posterPath: e.posterPath,
              title: e.name,
              voteAverage: e.voteAverage,
              releaseDate: e.firstAirDate,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.routeName,
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
                    PopularTvPage.routeName,
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
          child: Consumer<TvListProvider>(
            builder: (context, provider, widget) {
              final state = provider.popularTvState;

              if (state == ResultState.loaded) {
                return _popularLoaded(
                  context,
                  popularTv: provider.popularTv,
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
        ),
      ],
    );
  }

  Widget _popularLoaded(
    BuildContext context, {
    required List<Tv> popularTv,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: popularTv.map((e) {
          int index = popularTv.indexOf(e);
          int indexLength = popularTv.length;

          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 0,
              right: index == (indexLength - 1) ? 16 : 8,
            ),
            child: CardListWidget(
              id: e.id,
              posterPath: e.posterPath,
              title: e.name,
              voteAverage: e.voteAverage,
              releaseDate: e.firstAirDate,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.routeName,
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
                    TopRatedTvPage.routeName,
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
          child: Consumer<TvListProvider>(
            builder: (context, provider, widget) {
              final state = provider.topRatedTvState;

              if (state == ResultState.loaded) {
                return _topRatedLoaded(
                  context,
                  topRatedTv: provider.topRatedTv,
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
        ),
      ],
    );
  }

  Widget _topRatedLoaded(
    BuildContext context, {
    required List<Tv> topRatedTv,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: topRatedTv.map((e) {
          int index = topRatedTv.indexOf(e);
          int indexLength = topRatedTv.length;

          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 0,
              right: index == (indexLength - 1) ? 16 : 8,
            ),
            child: CardListWidget(
              id: e.id,
              posterPath: e.posterPath,
              title: e.name,
              voteAverage: e.voteAverage,
              releaseDate: e.firstAirDate,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.routeName,
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
