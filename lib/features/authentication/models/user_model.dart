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
}
