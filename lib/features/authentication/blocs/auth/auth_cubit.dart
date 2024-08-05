import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthCubit() : super(const AuthState()) {
    _auth.authStateChanges().listen((User? user) {

      emit(state.copyWith(isSignedIn: user != null));
    });
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      emit(state.copyWith(isSignedIn: false));
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
