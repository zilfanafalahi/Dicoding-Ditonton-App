import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationInitial()) {
    on<BottomNavigationSetPage>(_bottomNavigationSetPage);
  }

  Future<void> _bottomNavigationSetPage(
    BottomNavigationSetPage event,
    Emitter<BottomNavigationState> emit,
  ) async {
    emit(BottomNavigationPage(event.page));
  }
}
