import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guardowl/features/authentication/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _firestore = FirebaseFirestore.instance;

  AuthCubit() : super(const AuthState()) {
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        final currentUser = await _firestore
            .collection('users')
            .doc(user.uid)
            .withConverter<UserModel>(
              fromFirestore: (snapshot, _) => UserModel.fromFirebaseUser(
                snapshot.data()!,
              ).copyWith(uid: snapshot.id),
              toFirestore: (user, _) => user.toMapFirestore(),
            )
            .get();
        _newEmit(currentUser.data());
      } else {
        _newEmit(null);
      }
    });
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      _newEmit(null);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  void _newEmit(UserModel? user) {
    emit(state.copyWith(
      currentUser: user,
      isSignedIn: user != null,
    ));
  }
}
