class RMUser {
  final String firstName;
  final String lastName;
  final String email;
  final String uid;
  RMUser({this.firstName, this.lastName, this.email, this.uid});
}

class SigninData {
  String email;
  String password;
}

class RegistrationData {
  String email;
  String password;
  String firstName;
  String lastName;
}

enum UserOptions {
  UserScreen,
  Logout,
}
