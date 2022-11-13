import 'package:bloc_test/bloc_test.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/presentation/bloc/tv/popular_tv/popular_tv_bloc.dart';
import 'package:dicoding_ditonton_app/presentation/pages/tv/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularTvBloc extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}

class PopularTvEventFake extends Fake implements PopularTvEvent {}

class PopularTvStateFake extends Fake implements PopularTvState {}

void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUpAll(() {
    registerFallbackValue(PopularTvEventFake());
    registerFallbackValue(PopularTvStateFake());
  });

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
      value: mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state).thenReturn(PopularTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display GridView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state)
        .thenReturn(const PopularTvLoaded(<Tv>[]));

    final listViewFinder = find.byType(GridView);

    await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state)
        .thenReturn(const PopularTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
