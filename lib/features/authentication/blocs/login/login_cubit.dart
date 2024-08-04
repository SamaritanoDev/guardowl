import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:guardowl/features/authentication/infraestructura/inputs/inputs.dart';
part 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LogInCubit() : super(const LogInState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    final isValid = Formz.validate([email, state.password]);
    emit(state.copyWith(
      email: email,
      isValid: isValid,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final isValid = Formz.validate([state.email, password]);
    emit(state.copyWith(
      password: password,
      isValid: isValid,
    ));
  }

  Future<void> logInWithCredentials() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _auth.signInWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: e.message ?? "An unknown error occurred",
      ));
    }
  }

    void togglePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }
  
}
