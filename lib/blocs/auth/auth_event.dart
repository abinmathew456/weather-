part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  List<Object> get props => [];
}

class LoginButtonPress extends AuthEvent {
  String email;
  String password;

  LoginButtonPress({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
class LogInLoadedEvent extends AuthEvent {}