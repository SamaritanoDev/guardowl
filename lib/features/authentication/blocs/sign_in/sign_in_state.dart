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

class SignInState extends Equatable {
  final StatusAuth status;
  final String email;
  final String password;
  final bool passwordVisible;

  const SignInState({
    required this.status,
    this.email = '',
    this.password = '',
    this.passwordVisible = false,
  });

  bool get isLoading => status == const LoadingAuth();

  SignInState copyWhith({
    String? email,
    String? password,
    StatusAuth? status,
    bool? passwordVisible,
  }) =>
      SignInState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        passwordVisible: passwordVisible ?? this.passwordVisible,
      );

  @override
  List<Object> get props => [status, email, password, passwordVisible];
}
