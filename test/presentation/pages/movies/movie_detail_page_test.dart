import 'package:bloc_test/bloc_test.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/detail_movies/detail_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/movies/watchlist_status_movies/watchlist_status_movies_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/pages/movies/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconly/iconly.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/movies/dummy_objects_movies.dart';

class MockDetailMoviesBloc
    extends MockBloc<DetailMoviesEvent, DetailMoviesState>
    implements DetailMoviesBloc {}

class DetailMoviesEventFake extends Fake implements DetailMoviesEvent {}

class DetailMoviesStateFake extends Fake implements DetailMoviesState {}

class MockRecommendationMoviesBloc
    extends MockBloc<RecommendationMoviesEvent, RecommendationMoviesState>
    implements RecommendationMoviesBloc {}

class RecommendationMoviesEventFake extends Fake
    implements RecommendationMoviesEvent {}

class RecommendationMoviesStateFake extends Fake
    implements RecommendationMoviesState {}

class MockWatchlistStatusMoviesBloc
    extends MockBloc<WatchlistStatusMoviesEvent, WatchlistStatusMoviesState>
    implements WatchlistStatusMoviesBloc {}

class WatchlistStatusMoviesEventFake extends Fake
    implements WatchlistStatusMoviesEvent {}

class WatchlistStatusMoviesStateFake extends Fake
    implements WatchlistStatusMoviesState {}

void main() {
  late MockDetailMoviesBloc mockDetailMoviesBloc;
  late MockRecommendationMoviesBloc mockRecommendationMoviesBloc;
  late MockWatchlistStatusMoviesBloc mockWatchlistStatusMoviesBloc;

  setUpAll(() {
    registerFallbackValue(DetailMoviesEventFake());
    registerFallbackValue(DetailMoviesStateFake());
    registerFallbackValue(RecommendationMoviesEventFake());
    registerFallbackValue(RecommendationMoviesStateFake());
    registerFallbackValue(WatchlistStatusMoviesEventFake());
    registerFallbackValue(WatchlistStatusMoviesStateFake());
  });

  setUp(() {
    mockDetailMoviesBloc = MockDetailMoviesBloc();
    mockRecommendationMoviesBloc = MockRecommendationMoviesBloc();
    mockWatchlistStatusMoviesBloc = MockWatchlistStatusMoviesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMoviesBloc>.value(
          value: mockDetailMoviesBloc,
        ),
        BlocProvider<RecommendationMoviesBloc>.value(
          value: mockRecommendationMoviesBloc,
        ),
        BlocProvider<WatchlistStatusMoviesBloc>.value(
          value: mockWatchlistStatusMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.state).thenReturn(DetailMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.state)
        .thenReturn(const DetailMoviesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.state)
        .thenReturn(const DetailMoviesLoaded(testMoviesDetail));
    when(() => mockRecommendationMoviesBloc.state)
        .thenReturn(const RecommendationMoviesLoaded(<Movies>[]));
    when(() => mockWatchlistStatusMoviesBloc.state)
        .thenReturn(const IsSaveWatchlistStatusMovies(false));

    final watchlistButtonIcon = find.byIcon(IconlyLight.bookmark);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailMoviesBloc.state)
        .thenReturn(const DetailMoviesLoaded(testMoviesDetail));
    when(() => mockRecommendationMoviesBloc.state)
        .thenReturn(const RecommendationMoviesLoaded(<Movies>[]));
    when(() => mockWatchlistStatusMoviesBloc.state)
        .thenReturn(const IsSaveWatchlistStatusMovies(true));

    final watchlistButtonIcon = find.byIcon(IconlyBold.bookmark);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
