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
    print("Email changed: ${email.value}");

    final isValid = Formz.validate([email, state.password]);
    emit(state.copyWith(
      email: email,
      isValid: isValid,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    print("Password changed: ${password.value}");

    final isValid = Formz.validate([state.email, password]);
    emit(state.copyWith(
      password: password,
      isValid: isValid,
    ));
  }

  Future<void> logInWithCredentials() async {
    print("Attempting login...");
//todo: porque este emit esta fuera del try

    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      await _auth.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      print('Passowrd con logInWithCredentials: ${state.password.value}');

      emit(state.copyWith(status: FormzSubmissionStatus.success));
      print("Login successful");
    } on FirebaseAuthException catch (e) {
      print("Login failed: ${e.message}");

      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: e.message ?? "An unknown error occurred",
      ));
    }
  }

  void validtatingInputsLogIn() {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
      password: Password.dirty(state.password.value),
      email: Email.dirty(state.email.value),
      isValid: Formz.validate(
        [
          state.email,
          state.password,
        ],
      ),
    ));
    print('submit $state');
  }

  void togglePasswordVisibility() {
    print('Toggling password visibility');
    
    emit(state.copyWith(
      passwordVisible: !state.passwordVisible,
    ));
  }
}
