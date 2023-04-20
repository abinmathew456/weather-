
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/blocs/users/user_event.dart';
import 'package:machine_test/blocs/users/user_state.dart';
import 'package:machine_test/repositories/UserRepository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        List<Map<String, dynamic>>  users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });

  }
}