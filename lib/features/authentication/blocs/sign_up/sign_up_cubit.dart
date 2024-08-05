import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guardowl/features/authentication/infraestructura/inputs/inputs.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  SignUpCubit() : super(const SignUpState());

  void firstNameChanged(String value) {
    final firstName = FirstName.dirty(value);
    print("Email changed: ${firstName.value}");

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
    print("Email changed: ${lastName.value}");

    final isValid = Formz.validate(
      [
        lastName,
        state.firstName,
        state.email,
        state.password,
      ],
    );
    emit(state.copyWith(
      lastName: lastName,
      isValid: isValid,
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    print("Email changed: ${email.value}");

    final isValid = Formz.validate(
      [
        email,
        state.firstName,
        state.lastName,
        state.password,
      ],
    );
    emit(state.copyWith(
      email: email,
      isValid: isValid,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    print("Email changed: ${password.value}");

    final isValid = Formz.validate([
      state.email,
      state.firstName,
      state.lastName,
      password,
    ]);
    emit(state.copyWith(
      password: password,
      isValid: isValid,
    ));
  }

  Future<void> signUpWithCredentials() async {
    print("Attempting sign up...");

    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      await _auth.createUserWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      print("Sign up successful");
    } on FirebaseAuthException catch (error) {
      print("Sign up failed: ${error.message}");

      emit(state.copyWith(
          exceptionError: error.message.toString(),
          status: FormzSubmissionStatus.failure));
    } on PlatformException catch (error) {
      print("Sign up failed: ${error.message}");

      emit(state.copyWith(
          exceptionError: error.message.toString(),
          status: FormzSubmissionStatus.failure));
    } catch (error) {
      print("Sign up failed: Unexpected error");

      emit(state.copyWith(
          exceptionError: "Unexpected error please try again later",
          status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> signUpWithGoogle() async {
    print("Attempting Google sign up...");

    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          exceptionError: 'Google sign in was cancelled.',
        ));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
      print("Google sign up successful");
    } on FirebaseAuthException catch (error) {
      print("Google sign up failed: ${error.message}");

      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: error.message.toString(),
      ));
    } on PlatformException catch (error) {
      print("Google sign up failed: ${error.message}");
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        exceptionError: error.message.toString(),
      ));
    } catch (error) {
      print("Google sign up failed: Unexpected error");
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          exceptionError: 'Unexpected error please try again later.'));
    }
  }

  void validtatingInputsSignUp() {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
      firstName: FirstName.dirty(state.firstName.value),
      lastName: LastName.dirty(state.lastName.value),
      password: Password.dirty(state.password.value),
      email: Email.dirty(state.email.value),
      isValid: Formz.validate(
        [
          state.firstName,
          state.lastName,
          state.email,
          state.password,
        ],
      ),
    ));
    print('submit $state');
  }
}
