part of 'detail_tv_bloc.dart';

abstract class DetailTvEvent extends Equatable {
  const DetailTvEvent();

  @override
  List<Object> get props => [];
}

class DetailTvStarted extends DetailTvEvent {
  final int id;

  const DetailTvStarted({required this.id});

  @override
  List<Object> get props => [id];
}
