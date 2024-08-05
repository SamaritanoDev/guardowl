import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guardowl/features/authentication/infraestructura/inputs/inputs.dart';
import 'package:guardowl/features/authentication/models/user_model.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    ]);
    emit(state.copyWith(
      password: password,
      isValid: isValid,
    ));
  }

  Future<void> signUpWithCredentials() async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: state.email.value, password: state.password.value);

      // Save User in Firestore
      final user = userCredential.user;
      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          email: state.email.value,
          firstName: state.firstName.value,
          lastName: state.lastName.value,
          password: state.password.value,
        );

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toMapFirestore());

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    } on FirebaseAuthException catch (error) {
      print("Sign up failed: ${error.message}");

      emit(state.copyWith(
          exceptionError: _mapFirebaseAuthExceptionToMessage(error),
          status: FormzSubmissionStatus.failure));
    } on PlatformException catch (error) {
      print("Sign up failed: ${error.message}");

      emit(state.copyWith(
          exceptionError: error.message.toString(),
          status: FormzSubmissionStatus.failure));
    } catch (error) {
      emit(state.copyWith(
          exceptionError: "Unexpected error please try again later",
          status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> signUpWithGoogle() async {
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

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Check if user data already exists in Firestore
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          final userModel = UserModel(
            uid: user.uid,
            email: user.email ?? '',
            firstName: googleUser.displayName?.split(' ').first,
            lastName: googleUser.displayName?.split(' ').skip(1).join(' '),
            password: '', // Password is not save
          );

          // Save User in Firestore
          await _firestore
              .collection('users')
              .doc(user.uid)
              .set(userModel.toMapFirestore());
        }
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
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
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          exceptionError: 'Unexpected error please try again later.'));
    }
  }

  String _mapFirebaseAuthExceptionToMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'operation-not-allowed':
        return 'Operation not allowed.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'An unknown error occurred.';
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
  }
}
