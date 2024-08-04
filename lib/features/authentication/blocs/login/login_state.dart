part of 'login_cubit.dart';

class LogInState extends Equatable {
  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final String exceptionError;
  final bool isValid;
  final bool passwordVisible;

  const LogInState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.exceptionError = "",
    this.isValid = false,
    this.passwordVisible = false,
  });

  LogInState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    String? exceptionError,
    bool? isValid,
    bool? passwordVisible,
  }) =>
      LogInState(
          status: status ?? this.status,
          email: email ?? this.email,
          password: password ?? this.password,
          exceptionError: exceptionError ?? this.exceptionError,
          isValid: isValid ?? this.isValid,
          passwordVisible: passwordVisible ?? this.passwordVisible);

  @override
  List<Object> get props => [status, email, password, exceptionError, isValid];
}
