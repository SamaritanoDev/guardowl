import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:guardowl/features/authentication/infraestructura/inputs/inputs.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

 SignUpCubit() : super(const SignUpState());

  void firstNameChanged(String value) {
    final firstName = FirstName.dirty(value);
    final isValid = Formz.validate(
      [
        firstName,
        state.lastName,
        state.email,
        state.password,
        // state.rePassword,
      ],
    );
    emit(state.copyWith(
      firstName: firstName,
      isValid: isValid,
    ));
  }

  void lastNameChanged(String value) {
    final lastName = LastName.dirty(value);
    final isValid = Formz.validate(
      [
        lastName,
        state.firstName,
        state.email,
        state.password,
        // state.rePassword,
      ],
    );
    emit(state.copyWith(
      lastName: lastName,
      isValid: isValid,
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    final isValid = Formz.validate(
      [
        email,
        state.firstName,
        state.lastName,
        state.password,
        // state.rePassword,
      ],
    );
    emit(state.copyWith(
      email: email,
      isValid: isValid,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final isValid = Formz.validate([
      state.email,
      state.firstName,
      state.lastName,
      password,
      // state.rePassword,
    ]);
    emit(state.copyWith(
      password: password,
      isValid: isValid,
    ));
  }

  void signUpWithCredentials() async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await _auth.createUserWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
          exceptionError: error.message.toString(),
          status: FormzSubmissionStatus.failure));
    } on PlatformException catch (error) {
      emit(state.copyWith(
          exceptionError: error.message.toString(),
          status: FormzSubmissionStatus.failure));
    } catch (error) {
      emit(state.copyWith(
          exceptionError: "Unexpected error please try again later",
          status: FormzSubmissionStatus.failure));
    }
  }
}
