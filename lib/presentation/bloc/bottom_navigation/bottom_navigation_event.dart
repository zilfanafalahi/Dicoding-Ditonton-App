part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class BottomNavigationSetPage extends BottomNavigationEvent {
  final int page;

  const BottomNavigationSetPage({required this.page});

  @override
  List<Object> get props => [page];
}
