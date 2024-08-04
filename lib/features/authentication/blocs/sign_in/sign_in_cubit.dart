import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:guardowl/features/authentication/infraestructura/inputs/inputs.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInCubit(StatusAuth status)
      : super(
          SignInState(
            status: status,
          ),
        );

  Future<void> onSubmit() async {
    emit(state.copyWith(status: const LoadingAuth()));

    try {
      final email = state.email.value;
      final password = state.password.value;

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(state.copyWith(status: Authenticated()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(state.copyWith(status: NotRegistered()));
      } else {
        emit(state.copyWith(
            status: ErrorAuth(error: e.message ?? 'Unknown error')));
      }
    } catch (e) {
      emit(state.copyWith(
          status: ErrorAuth(error: 'An unexpected error occurred')));
    }
  }

  void onChangeEmail(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(
          [
            email,
            state.password,
          ],
        ),
      ),
    );
  }

  void onChangePassword(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([
        password,
        state.email,
      ]),
    ));
  }

  void logOut() {
    _auth.signOut();
    emit(state.copyWith(status: NotAuthenticated()));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  void toggleAuthMode() {
    if (state.status is NotAuthenticated) {
      emit(state.copyWith(status: NotRegistered()));
      print("estado de is NotRegistered: ${state.status}");
    } else {
      emit(state.copyWith(status: NotAuthenticated()));
      print("estado de is NotAuthenticated: ${state.status}");
    }
  }
}
