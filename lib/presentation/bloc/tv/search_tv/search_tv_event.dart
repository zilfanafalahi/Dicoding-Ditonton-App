part of 'search_tv_bloc.dart';

abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();

  @override
  List<Object> get props => [];
}

class SearchTvStarted extends SearchTvEvent {
  final String query;

  const SearchTvStarted({required this.query});

  @override
  List<Object> get props => [query];
}
