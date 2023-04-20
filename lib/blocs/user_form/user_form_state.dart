part of 'user_form_bloc.dart';

@immutable
abstract class UserFormState {}

class UserFormInitial extends UserFormState {}
class UserFormSuccessful extends UserFormState {}

class UserFormError extends UserFormState {
  String error;
  UserFormError(this.error);
}
