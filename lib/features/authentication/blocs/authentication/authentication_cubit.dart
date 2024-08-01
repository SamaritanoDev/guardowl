import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:guardowl/features/authentication/infraestructura/inputs/inputs.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState());

  void onSubmit() {
    emit(state.copyWith(
      formStatus: FormStatus.validating,
      firstName: FirstName.dirty(state.firstName.value),
      lastName: LastName.dirty(state.lastName.value),
      email: Email.dirty(state.email.value),
      password: Password.dirty(state.password.value),
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

  //metodos: emitir valores
  void firstNameChanged(String value) {
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

  void lastNameChanged(String value) {
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

  void emailChanged(String value) {
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

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          password,
          state.firstName,
          state.lastName,
          state.email,
        ]),
      ),
    );
  }
}
