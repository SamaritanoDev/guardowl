import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:guardowl/features/authentication/infraestructura/inputs/inputs.dart';
part 'valid_form_register_state.dart';

class ValidFormRegisterCubit extends Cubit<ValidFormRegisterState> {
  ValidFormRegisterCubit(StatusValidForm formStatus)
      : super(ValidFormRegisterState(
          formStatus: formStatus,
        ));

  void validForm() {
    emit(
      state.copyWith(
        formStatus: Validating(),
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
}
