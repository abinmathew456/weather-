
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machine_test/repositories/auth_repository.dart';
import 'package:machine_test/services/emailValidation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthLoading()) {
    on<LoginButtonPress>((event, emit) async {
      if (event.email!.isEmpty){
        emit(AuthError('Email cannot be empty!'));
      } else if (EmailValidation.validateEmailAddress(event.email!)==false)
      {
        emit(AuthError('Invalid Email'));
      }
       else if (event.password!.isEmpty)
      {
        emit(AuthError('Password cannot be empty!'));
      } else {
       
         if(event.email=="thoughtbox@google.com"&&event.password=="Test@123456") {
           final SharedPreferences prefs = await SharedPreferences.getInstance();

           await prefs.setBool('lodinStatus', true);
           emit(AuthSuccessful());
         }else{
           emit(AuthError('Please enter valid credentials'));
         }
        /*emit(AuthLoading());
        final result = await _authRepository.login(event.email!, event.password!);
        print(result);
        if(result != "user not found"){
          emit(AuthSuccessful());
        }
        if(result == "user not found"){
          emit(AuthError('User not found Or Something wrong'));
        }*/

            }
    });
  }


}
