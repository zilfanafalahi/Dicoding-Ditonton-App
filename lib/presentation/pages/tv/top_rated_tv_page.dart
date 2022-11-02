import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/tv_detail_page.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/top_rated_tv_provider.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_grid_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/error_custom_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/loading_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTvPage extends StatelessWidget {
  static const routeName = '/top_rated_tv_page';

  const TopRatedTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() =>
        Provider.of<TopRatedTvProvider>(context, listen: false)
            .fetchTopRatedTv());

    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Text(
        "Top Rated Tv Shows",
        style: kTextTheme.headline6!.apply(
          color: kWhiteColor,
        ),
      ),
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    return Consumer<TopRatedTvProvider>(
      builder: (context, provider, widget) {
        final state = provider.state;

        if (state == ResultState.loaded) {
          return _topRatedLoaded(
            context,
            tv: provider.tv,
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
    required List<Tv> tv,
  }) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 283,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: tv.length,
      itemBuilder: (BuildContext context, index) {
        return CardGridWidget(
          id: tv[index].id,
          posterPath: tv[index].posterPath,
          title: tv[index].name,
          voteAverage: tv[index].voteAverage,
          releaseDate: tv[index].firstAirDate,
          onTap: () {
            Navigator.pushNamed(
              context,
              TvDetailPage.routeName,
              arguments: tv[index].id,
            );
          },
        );
      },
    );
  }
}
