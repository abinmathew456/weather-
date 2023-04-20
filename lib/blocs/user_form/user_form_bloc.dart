import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/services/db.dart';
import 'package:machine_test/services/emailValidation.dart';
import 'package:meta/meta.dart';
part 'user_form_event.dart';
part 'user_form_state.dart';

class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {
  UserFormBloc() : super(UserFormInitial()) {
    on<SubmitButtonPress>((event, emit) async {
      if (event.fname!.isEmpty){
        emit(UserFormError('First name cannot be empty!'));
      }
      else if (event.lname!.isEmpty)
      {
        emit(UserFormError('Last name cannot be empty!'));
      }else if (event.email!.isEmpty)
      {
        emit(UserFormError('Email cannot be empty!'));
      }else if (EmailValidation.validateEmailAddress(event.email!)==false)
      {
        emit(UserFormError('Invalid Email'));
      } else {
        Db.insertData(event.fname,event.lname,event.email);
        emit(UserFormSuccessful());
      }
    });
  }
}
