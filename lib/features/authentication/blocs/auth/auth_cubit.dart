import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(const AuthState()) {
    _auth.authStateChanges().listen((User? user) {
        print("Auth state changed: ${user != null}");
        
      emit(state.copyWith(isSignedIn: user != null));
    });
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      emit(state.copyWith(isSignedIn: false));
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
