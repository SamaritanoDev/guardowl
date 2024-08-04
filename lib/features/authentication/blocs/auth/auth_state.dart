part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool isSignedIn;
  const AuthState({
    this.isSignedIn = false,
  });

  AuthState copyWith({
    bool? isSignedIn,
  }) =>
      AuthState(
        isSignedIn: isSignedIn ?? this.isSignedIn,
      );

  @override
  List<Object> get props => [isSignedIn];
}
