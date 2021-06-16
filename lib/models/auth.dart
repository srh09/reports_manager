class RMUser {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? uid;
  RMUser({this.firstName, this.lastName, this.email, this.uid});
}

class SigninData {
  late String email;
  late String password;
}

class RegistrationData {
  late String email;
  late String password;
  String? firstName;
  String? lastName;
}

enum UserOptions {
  UserScreen,
  Logout,
}
