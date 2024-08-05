import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String? firstName;
  final String? lastName;
  final String password;

  UserModel({
    required this.uid,
    required this.email,
    this.firstName,
    this.lastName,
    required this.password,
  });

  factory UserModel.fromFirebaseUser(User user, Map<String, dynamic> userData) {
    final firstName = userData['firstName'] as String? ?? '';
    final lastName = userData['lastName'] as String? ?? '';
    final email = userData['email'] as String? ?? '';

    return UserModel(
      uid: user.uid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: '',
    );
  }

  Map<String, dynamic> toMapFirestore() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
}
