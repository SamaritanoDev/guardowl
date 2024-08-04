part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final FormzSubmissionStatus status;
  final FirstName firstName;
  final LastName lastName;
  final Email email;
  final Password password;
  final String exceptionError;
  final bool isValid;

  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.exceptionError = "",
    this.isValid = false,
  });

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    final FirstName? firstName,
    final LastName? lastName,
    Email? email,
    Password? password,
    RePassword? rePassword,
    String? exceptionError,
    bool? isValid,
  }) =>
      SignUpState(
        status: status ?? this.status,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        exceptionError: exceptionError ?? this.exceptionError,
        isValid: isValid ?? this.isValid,
      );

  @override
  List<Object> get props =>
      [status, firstName, lastName, email, password, exceptionError, isValid];
}
