// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    this.firstName,
    this.lastName,
    required this.password,
  });

  final String uid;
  final String email;
  final String? firstName;
  final String? lastName;
  final String password;

  factory UserModel.fromFirebaseUser(Map<String, dynamic> data) {
    final firstName = data['firstName'] as String? ?? '';
    final lastName = data['lastName'] as String? ?? '';
    final email = data['email'] as String? ?? '';
    final uid = data['uid'] as String? ?? '';

    return UserModel(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: '', // '?'
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

  UserModel copyWith({
    String? uid,
    String? email,
    String? firstName,
    String? lastName,
    String? password,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, firstName: $firstName, lastName: $lastName, password: $password)';
  }
}
