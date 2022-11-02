import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/tv_detail_page.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/tv_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconly/iconly.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailProvider])
void main() {
  late MockTvDetailProvider mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailProvider();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailProvider>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(ResultState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(ResultState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(ResultState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.tvRecommendationState).thenReturn(ResultState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(IconlyLight.bookmark);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(ResultState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.tvRecommendationState).thenReturn(ResultState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(IconlyBold.bookmark);

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(ResultState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.tvRecommendationState).thenReturn(ResultState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byKey(
      const Key("inkwell_add_watchlist_key"),
    );

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(IconlyLight.bookmark), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(ResultState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.tvRecommendationState).thenReturn(ResultState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byKey(
      const Key("inkwell_add_watchlist_key"),
    );

    await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

    expect(find.byIcon(IconlyLight.bookmark), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
