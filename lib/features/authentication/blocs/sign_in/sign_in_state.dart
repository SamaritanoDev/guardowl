part of 'sign_in_cubit.dart';

sealed class StatusAuth {
  const StatusAuth();
}

class Authenticated extends StatusAuth {}

class NotAuthenticated extends StatusAuth {}

class NotRegistered extends StatusAuth {}

class ErrorAuth extends StatusAuth {
  final Object error;

  ErrorAuth({required this.error});
}

class LoadingAuth extends StatusAuth {
  const LoadingAuth();
}

class SignInState extends Equatable {
  final StatusAuth status;
  final Email email;
  final Password password;
  final bool passwordVisible;

  const SignInState({
    required this.status,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.passwordVisible = false,
  });

  bool get isLoading => status == const LoadingAuth();

  SignInState copyWith({
    StatusAuth? status,
    bool? isValid,
    Email? email,
    Password? password,
    bool? passwordVisible,
  }) =>
      SignInState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordVisible: passwordVisible ?? this.passwordVisible,
      );

  @override
  List<Object> get props => [status, email, password, passwordVisible];
}
