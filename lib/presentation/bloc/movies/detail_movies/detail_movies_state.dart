part of 'detail_movies_bloc.dart';

abstract class DetailMoviesState extends Equatable {
  const DetailMoviesState();

  @override
  List<Object> get props => [];
}

class DetailMoviesInitial extends DetailMoviesState {}

class DetailMoviesLoading extends DetailMoviesState {}

class DetailMoviesError extends DetailMoviesState {
  final String message;

  const DetailMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailMoviesLoaded extends DetailMoviesState {
  final MoviesDetail result;

  const DetailMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}
