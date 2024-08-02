import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInCubit(StatusAuth status) : super(SignInState(status: status));

  Future<void> onSubmit() async {
    emit(state.copyWhith(status: const LoadingAuth()));

    try {
      await _auth.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      emit(
        state.copyWhith(status: Authenticated()),
      );
    } catch (e) {
      emit(state.copyWhith(status: ErrorAuth(error: e)));
    }
  }

  void logOut() {
    _auth.signOut();
    emit(state.copyWhith(status: NotAuthenticated()));
  }

  void togglePasswordVisibility() {
    emit(state.copyWhith(passwordVisible: !state.passwordVisible));
  }
}
