part of 'sign_in_cubit.dart';

sealed class StatusAuth {
  const StatusAuth();
}

class Authenticated extends StatusAuth {}

class NotAuthenticated extends StatusAuth {}

class ErrorAuth extends StatusAuth {
  final Object error;

  ErrorAuth({required this.error});
}

class LoadingAuth extends StatusAuth {
  const LoadingAuth();
}

//login and registration form validation statuses
class Invalid extends StatusAuth {}

class Valid extends StatusAuth {}

class Validating extends StatusAuth {}

class SignInState extends Equatable {
  final StatusAuth status;
  final bool isValid;
  final FirstName firstName;
  final LastName lastName;
  final Email email;
  final Password password;
  final bool passwordVisible;

  const SignInState({
    required this.status,
    this.isValid = false,
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.passwordVisible = false,
  });

  bool get isLoading => status == const LoadingAuth();

  SignInState copyWith({
    StatusAuth? status,
    bool? isValid,
    FirstName? firstName,
    LastName? lastName,
    Email? email,
    Password? password,
    bool? passwordVisible,
  }) =>
      SignInState(
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordVisible: passwordVisible ?? this.passwordVisible,
      );

  @override
  List<Object> get props =>
      [status, isValid, firstName, lastName, email, password, passwordVisible];
}
