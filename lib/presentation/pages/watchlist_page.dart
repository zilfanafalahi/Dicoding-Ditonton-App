import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/route_observer.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/pages/movies/movie_detail_page.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/tv_detail_page.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/card_grid_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/data_not_available_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/error_custom_widget.dart';
import 'package:dicoding_ditonton_app/presentation/widgets/loading_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist_page';

  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with TickerProviderStateMixin, RouteAware {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() {
      context.read<WatchlistMoviesBloc>().add(WatchlistMoviesStarted());
      context.read<WatchlistTvBloc>().add(WatchlistTvStarted());
    });
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(WatchlistMoviesStarted());
    context.read<WatchlistTvBloc>().add(WatchlistTvStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: TabBarView(
        controller: _tabController,
        children: [
          _bodyMovies(context),
          _bodyTv(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Text(
        "Watchlist",
        style: kTextTheme.headline6!.apply(
          color: kWhiteColor,
        ),
      ),
      bottom: TabBar(
        controller: _tabController,
        tabs: const <Widget>[
          Tab(
            icon: Icon(IconlyLight.ticket),
          ),
          Tab(
            icon: Icon(IconlyLight.play),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
    );
  }

  Widget _bodyMovies(BuildContext context) {
    return BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
      builder: (context, state) {
        if (state is WatchlistMoviesLoaded) {
          return _loadedMovies(
            context,
            watchlistMovies: state.result,
          );
        }

        if (state is WatchlistMoviesError) {
          return ErrorCustomWidget(
            key: const Key('error_message'),
            message: state.message,
          );
        }

        if (state is WatchlistMoviesLoading) {
          return const LoadingCustomWidget();
        }

        return const SizedBox();
      },
    );
  }

  Widget _loadedMovies(
    BuildContext context, {
    required List<Movies> watchlistMovies,
  }) {
    return watchlistMovies.isNotEmpty
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 283,
            ),
            padding: const EdgeInsets.all(16),
            itemCount: watchlistMovies.length,
            itemBuilder: (BuildContext context, index) {
              return CardGridWidget(
                id: watchlistMovies[index].id,
                posterPath: watchlistMovies[index].posterPath,
                title: watchlistMovies[index].title,
                voteAverage: watchlistMovies[index].voteAverage,
                releaseDate: watchlistMovies[index].releaseDate,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MovieDetailPage.routeName,
                    arguments: watchlistMovies[index].id,
                  );
                },
              );
            },
          )
        : const DataNotAvailableWidet();
  }

  Widget _bodyTv(BuildContext context) {
    return BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
      builder: (context, state) {
        if (state is WatchlistTvLoaded) {
          return _loadedTv(
            context,
            watchlistTv: state.result,
          );
        }

        if (state is WatchlistTvError) {
          return ErrorCustomWidget(
            key: const Key('error_message'),
            message: state.message,
          );
        }

        if (state is WatchlistTvLoading) {
          return const LoadingCustomWidget();
        }

        return const SizedBox();
      },
    );
  }

  Widget _loadedTv(
    BuildContext context, {
    required List<Tv> watchlistTv,
  }) {
    return watchlistTv.isNotEmpty
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 283,
            ),
            padding: const EdgeInsets.all(16),
            itemCount: watchlistTv.length,
            itemBuilder: (BuildContext context, index) {
              return CardGridWidget(
                id: watchlistTv[index].id,
                posterPath: watchlistTv[index].posterPath,
                title: watchlistTv[index].name,
                voteAverage: watchlistTv[index].voteAverage,
                releaseDate: watchlistTv[index].firstAirDate,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TvDetailPage.routeName,
                    arguments: watchlistTv[index].id,
                  );
                },
              );
            },
          )
        : const DataNotAvailableWidet();
  }
}
