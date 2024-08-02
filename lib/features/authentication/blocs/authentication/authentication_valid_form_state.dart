part of 'authentication_valid_form_cubit.dart';

enum FormStatus { invalid, valid, validating }

class AuthenticationValidFormState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final FirstName firstName;
  final LastName lastName;
  final Email email;
  final Password password;

  const AuthenticationValidFormState({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  AuthenticationValidFormState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    FirstName? firstName,
    LastName? lastName,
    Email? email,
    Password? password,
  }) =>
      AuthenticationValidFormState(
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
