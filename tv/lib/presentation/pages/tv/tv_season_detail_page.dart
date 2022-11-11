import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/entities/tv/tv_season_detail.dart';
import 'package:tv/presentation/bloc/tv/season_detail_tv/season_detail_tv_bloc.dart';

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
    Future.microtask(
      () => context.read<SeasonDetailTvBloc>().add(SeasonDetailTvStarted(
            id: args.id,
            seasonNumber: args.seasonNumber,
          )),
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
        args.name,
        style: kTextTheme.headline6!.apply(
          color: kWhiteColor,
        ),
      ),
      elevation: 0,
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<SeasonDetailTvBloc, SeasonDetailTvState>(
      builder: (context, state) {
        if (state is SeasonDetailTvLoaded) {
          return _tvSeasonDetailLoaded(
            context,
            tvSeasonDetail: state.result,
          );
        }

        if (state is SeasonDetailTvError) {
          return ErrorCustomWidget(
            key: const Key('error_message'),
            message: state.message,
          );
        }

        if (state is SeasonDetailTvLoading) {
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
