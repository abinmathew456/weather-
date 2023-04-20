part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccessful extends AuthState {}

class AuthError extends AuthState {
  String error;

  AuthError(this.error);

  @override
  List<Object> get props => [error];
}
