import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:dicoding_ditonton_app/presentation/provider/tv/top_rated_tv_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_tv_page_test.mocks.dart';

@GenerateMocks([TopRatedTvProvider])
void main() {
  late MockTopRatedTvProvider mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvProvider();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvProvider>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(ResultState.loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(ResultState.loaded);
    when(mockNotifier.tv).thenReturn(<Tv>[]);

    final listViewFinder = find.byType(GridView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(ResultState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
