import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconly/iconly.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';

class MockDetailTvBloc extends MockBloc<DetailTvEvent, DetailTvState>
    implements DetailTvBloc {}

class DetailTvEventFake extends Fake implements DetailTvEvent {}

class DetailTvStateFake extends Fake implements DetailTvState {}

class MockRecommendationTvBloc
    extends MockBloc<RecommendationTvEvent, RecommendationTvState>
    implements RecommendationTvBloc {}

class RecommendationTvEventFake extends Fake implements RecommendationTvEvent {}

class RecommendationTvStateFake extends Fake implements RecommendationTvState {}

class MockWatchlistStatusTvBloc
    extends MockBloc<WatchlistStatusTvEvent, WatchlistStatusTvState>
    implements WatchlistStatusTvBloc {}

class WatchlistStatusTvEventFake extends Fake
    implements WatchlistStatusTvEvent {}

class WatchlistStatusTvStateFake extends Fake
    implements WatchlistStatusTvState {}

void main() {
  late MockDetailTvBloc mockDetailTvBloc;
  late MockRecommendationTvBloc mockRecommendationTvBloc;
  late MockWatchlistStatusTvBloc mockWatchlistStatusTvBloc;

  setUpAll(() {
    registerFallbackValue(DetailTvEventFake());
    registerFallbackValue(DetailTvStateFake());
    registerFallbackValue(RecommendationTvEventFake());
    registerFallbackValue(RecommendationTvStateFake());
    registerFallbackValue(WatchlistStatusTvEventFake());
    registerFallbackValue(WatchlistStatusTvStateFake());
  });

  setUp(() {
    mockDetailTvBloc = MockDetailTvBloc();
    mockRecommendationTvBloc = MockRecommendationTvBloc();
    mockWatchlistStatusTvBloc = MockWatchlistStatusTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvBloc>.value(
          value: mockDetailTvBloc,
        ),
        BlocProvider<RecommendationTvBloc>.value(
          value: mockRecommendationTvBloc,
        ),
        BlocProvider<WatchlistStatusTvBloc>.value(
          value: mockWatchlistStatusTvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockDetailTvBloc.state).thenReturn(DetailTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockDetailTvBloc.state)
        .thenReturn(const DetailTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailTvBloc.state)
        .thenReturn(const DetailTvLoaded(testTvDetail));
    when(() => mockRecommendationTvBloc.state)
        .thenReturn(const RecommendationTvLoaded(<Tv>[]));
    when(() => mockWatchlistStatusTvBloc.state)
        .thenReturn(const IsSaveWatchlistStatusTv(false));

    final watchlistButtonIcon = find.byIcon(IconlyLight.bookmark);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailTvBloc.state)
        .thenReturn(const DetailTvLoaded(testTvDetail));
    when(() => mockRecommendationTvBloc.state)
        .thenReturn(const RecommendationTvLoaded(<Tv>[]));
    when(() => mockWatchlistStatusTvBloc.state)
        .thenReturn(const IsSaveWatchlistStatusTv(true));

    final watchlistButtonIcon = find.byIcon(IconlyBold.bookmark);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
