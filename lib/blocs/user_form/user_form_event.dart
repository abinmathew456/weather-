part of 'user_form_bloc.dart';

class UserFormEvent {}

class SubmitButtonPress extends UserFormEvent {
  String fname,lname,email;

  SubmitButtonPress({required this.fname, required this.lname, required this.email});
}