import 'package:dicoding_ditonton_app/domain/entities/movies/movies_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_movies_event.dart';
part 'detail_movies_state.dart';

class DetailMoviesBloc extends Bloc<DetailMoviesEvent, DetailMoviesState> {
  final GetMovieDetail getMovieDetail;

  DetailMoviesBloc({
    required this.getMovieDetail,
  }) : super(DetailMoviesInitial()) {
    on<DetailMoviesStarted>(_detailMoviesStarted);
  }

  Future<void> _detailMoviesStarted(
    DetailMoviesStarted event,
    Emitter<DetailMoviesState> emit,
  ) async {
    emit(DetailMoviesLoading());

    final result = await getMovieDetail.execute(event.id);

    result.fold(
      (failure) {
        emit(DetailMoviesError(failure.message));
      },
      (data) {
        emit(DetailMoviesLoaded(data));
      },
    );
  }
}
