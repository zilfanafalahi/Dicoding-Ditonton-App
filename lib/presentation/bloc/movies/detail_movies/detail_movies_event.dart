part of 'detail_movies_bloc.dart';

abstract class DetailMoviesEvent extends Equatable {
  const DetailMoviesEvent();

  @override
  List<Object> get props => [];
}

class DetailMoviesStarted extends DetailMoviesEvent {
  final int id;

  const DetailMoviesStarted({required this.id});

  @override
  List<Object> get props => [id];
}
