import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/presentation/pages/movies/movie_detail_page.dart';
import 'package:dicoding_ditonton_app/presentation/provider/movies/movies_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iconly/iconly.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/movies/dummy_objects_movies.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MoviesDetailProvider])
void main() {
  late MockMoviesDetailProvider mockNotifier;

  setUp(() {
    mockNotifier = MockMoviesDetailProvider();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MoviesDetailProvider>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(ResultState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(ResultState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(textFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(ResultState.loaded);
    when(mockNotifier.movie).thenReturn(testMoviesDetail);
    when(mockNotifier.movieRecommendationState).thenReturn(ResultState.loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movies>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(IconlyLight.bookmark);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(ResultState.loaded);
    when(mockNotifier.movie).thenReturn(testMoviesDetail);
    when(mockNotifier.movieRecommendationState).thenReturn(ResultState.loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movies>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(IconlyBold.bookmark);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(ResultState.loaded);
    when(mockNotifier.movie).thenReturn(testMoviesDetail);
    when(mockNotifier.movieRecommendationState).thenReturn(ResultState.loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movies>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byKey(
      const Key("inkwell_add_watchlist_key"),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(IconlyLight.bookmark), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(ResultState.loaded);
    when(mockNotifier.movie).thenReturn(testMoviesDetail);
    when(mockNotifier.movieRecommendationState).thenReturn(ResultState.loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movies>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byKey(
      const Key("inkwell_add_watchlist_key"),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(IconlyLight.bookmark), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
