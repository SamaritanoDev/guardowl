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

  void validForm() {
    emit(
      state.copyWith(
        status: Validating(),
        firstName: FirstName.dirty(state.firstName.value),
        lastName: LastName.dirty(state.lastName.value),
        email: Email.dirty(state.email.value),
        password: Password.dirty(state.password.value),
        isValid: Formz.validate([
          state.firstName,
          state.lastName,
          state.email,
          state.password,
        ]),
      ),
    );
  }

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
      emit(state.copyWith(
          status: ErrorAuth(error: e.message ?? 'Unknown error')));
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
            state.firstName,
            state.lastName,
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
        state.firstName,
        state.lastName,
        state.email,
      ]),
    ));
  }

  void onFirstNameChanged(String value) {
    final firstName = FirstName.dirty(value);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate(
          [
            firstName,
            state.lastName,
            state.email,
            state.password,
          ],
        ),
      ),
    );
  }

  void onLastNameChanged(String value) {
    final lastName = LastName.dirty(value);
    emit(
      state.copyWith(
        lastName: lastName,
        isValid: Formz.validate(
          [
            state.firstName,
            lastName,
            state.email,
            state.password,
          ],
        ),
      ),
    );
  }

  void logOut() {
    _auth.signOut();
    emit(state.copyWith(status: NotAuthenticated()));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }
}
