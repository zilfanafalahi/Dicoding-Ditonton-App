import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv_season_detail.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/tv_season_detail_provider.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_season_detail_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/error_custom_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/loading_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeasonDetailPageArgs {
  final String name;
  final int id;
  final int seasonNumber;

  TvSeasonDetailPageArgs({
    required this.name,
    required this.id,
    required this.seasonNumber,
  });
}

class TvSeasonDetailPage extends StatelessWidget {
  static const routeName = '/tv_season_detail_page';

  final TvSeasonDetailPageArgs args;

  const TvSeasonDetailPage({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    Future.microtask(() =>
        Provider.of<TvSeasonDetailProvider>(context, listen: false)
            .fetchTvSeasonDetail(args.id, args.seasonNumber));

    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Text(
        args.name,
        style: kTextTheme.headline6!.apply(
          color: kWhiteColor,
        ),
      ),
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    return Consumer<TvSeasonDetailProvider>(
      builder: (context, provider, widget) {
        final state = provider.tvSeasonDetailState;

        if (state == ResultState.loaded) {
          return _tvSeasonDetailLoaded(
            context,
            tvSeasonDetail: provider.tvSeasonDetail,
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

  Widget _tvSeasonDetailLoaded(
    BuildContext context, {
    required TvSeasonDetail tvSeasonDetail,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tvSeasonDetail.episodes.length,
      itemBuilder: (context, index) {
        return CardSeasonDetailWidget(
          id: tvSeasonDetail.episodes[index].id,
          seasonNumber: tvSeasonDetail.episodes[index].seasonNumber,
          stillPath: tvSeasonDetail.episodes[index].stillPath,
          episodeNumber: tvSeasonDetail.episodes[index].episodeNumber,
          name: tvSeasonDetail.episodes[index].name,
          airDate: tvSeasonDetail.episodes[index].airDate,
          runtime: tvSeasonDetail.episodes[index].runtime,
          overview: tvSeasonDetail.episodes[index].overview,
          voteAverage: tvSeasonDetail.episodes[index].voteAverage,
        );
      },
    );
  }
}
