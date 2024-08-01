part of 'authentication_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class AuthenticationState extends Equatable {
  final FormStatus formStatus;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const AuthenticationState({
    this.formStatus = FormStatus.invalid,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
  });

  AuthenticationState copyWith({
    FormStatus? formStatus,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) =>
      AuthenticationState(
        formStatus: formStatus ?? this.formStatus,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [formStatus, firstName, lastName, email, password];
}
