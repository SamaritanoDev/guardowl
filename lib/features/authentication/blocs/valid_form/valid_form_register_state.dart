part of 'valid_form_register_cubit.dart';

sealed class StatusValidForm {
  const StatusValidForm();
}

class Invalid extends StatusValidForm {}

class Valid extends StatusValidForm {}

class Validating extends StatusValidForm {}

class ValidFormRegisterState extends Equatable {
  final StatusValidForm formStatus;
  final bool isValid;
  final FirstName firstName;
  final LastName lastName;
  final Email email;
  final Password password;

  const ValidFormRegisterState({
    required this.formStatus,
    this.isValid = false,
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  ValidFormRegisterState copyWith({
    StatusValidForm? formStatus,
    bool? isValid,
    FirstName? firstName,
    LastName? lastName,
    Email? email,
    Password? password,
    bool? passwordVisible,
  }) =>
      ValidFormRegisterState(
        formStatus: formStatus ?? this.formStatus,
        isValid: isValid ?? this.isValid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object> get props =>
      [formStatus, isValid, firstName, lastName, email, password];
}
