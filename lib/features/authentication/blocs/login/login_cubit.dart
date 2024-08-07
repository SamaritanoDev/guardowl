import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guardowl/features/authentication/infraestructura/inputs/inputs.dart';
part 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
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
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final FirebaseAuth auth = FirebaseAuth.instance;

      await auth.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      print('Passowrd con logInWithCredentials: ${state.password.value}');

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on FirebaseAuthException catch (e) {
      print("Login failed: ${e.message}");

      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: e.message ?? "An unknown error occurred.",
      ));
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on FirebaseAuthException catch (e) {
      print("Google login failed: ${e.message}");

      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: e.message ?? "An unknown error occurred",
      ));
    } catch (e) {
      print("Google login failed: $e");

      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: "An unknown error occurred",
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
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(
      passwordVisible: !state.passwordVisible,
    ));
  }
}
