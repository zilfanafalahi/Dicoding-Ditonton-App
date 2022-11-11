import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/presentation/bloc/tv/on_the_air_tv/on_the_air_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/popular_tv_page.dart';
import 'package:tv/presentation/pages/tv/search_delegate_tv_page.dart';
import 'package:tv/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';

class TvPage extends StatelessWidget {
  static const routeName = '/tv_page';

  const TvPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(
      () {
        context.read<OnTheAirTvBloc>().add(OnTheAirTvStarted());
        context.read<PopularTvBloc>().add(PopularTvStarted());
        context.read<TopRatedTvBloc>().add(TopRatedTvStarted());
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
          child: BlocBuilder<OnTheAirTvBloc, OnTheAirTvState>(
            builder: (context, state) {
              if (state is OnTheAirTvLoaded) {
                return _onTheAirLoaded(
                  context,
                  onTheAirTv: state.result,
                );
              }

              if (state is OnTheAirTvError) {
                return ErrorCustomWidget(
                  message: state.message,
                );
              }

              if (state is OnTheAirTvLoading) {
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
          child: BlocBuilder<PopularTvBloc, PopularTvState>(
            builder: (context, state) {
              if (state is PopularTvLoaded) {
                return _popularLoaded(
                  context,
                  popularTv: state.result,
                );
              }

              if (state is PopularTvError) {
                return ErrorCustomWidget(
                  message: state.message,
                );
              }

              if (state is PopularTvLoading) {
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
          child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
            builder: (context, state) {
              if (state is TopRatedTvLoaded) {
                return _topRatedLoaded(
                  context,
                  topRatedTv: state.result,
                );
              }

              if (state is TopRatedTvError) {
                return ErrorCustomWidget(
                  message: state.message,
                );
              }

              if (state is TopRatedTvLoading) {
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
