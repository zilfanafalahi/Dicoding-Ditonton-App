part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class BottomNavigationInitial extends BottomNavigationState {}

class BottomNavigationPage extends BottomNavigationState {
  final int page;

  const BottomNavigationPage(this.page);

  @override
  List<Object> get props => [page];
}
