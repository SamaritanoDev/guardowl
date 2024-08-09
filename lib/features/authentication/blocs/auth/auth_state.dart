part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.isSignedIn = false,
    this.currentUser,
  });

  final bool isSignedIn;
  final UserModel? currentUser;

  String get fullName => '${currentUser?.firstName} ${currentUser?.lastName}';
  String get email => '${currentUser?.email}';

  AuthState copyWith({
    bool? isSignedIn,
    UserModel? currentUser,
  }) =>
      AuthState(
        isSignedIn: isSignedIn ?? this.isSignedIn,
        currentUser: currentUser ?? this.currentUser,
      );

  @override
  List<Object> get props => [isSignedIn];
}
