class Validators {
  static String? email(String? email) {
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email == null || email.isEmpty)
      return 'Email address is required';
    else if (!regExp.hasMatch(email))
      return 'Email address is invalid';
    else
      return null;
  }

  static String? password(String? password) {
    if (password == null || password.isEmpty)
      return 'Password is required';
    else if (password.length < 5)
      return 'Password must have at least 6 characters';
    else
      return null;
  }

  static String? passwordMatch(String? newPassword, String originalPassword) {
    if (newPassword == null || newPassword.isEmpty)
      return 'Password is required';
    else if (newPassword.length < 5)
      return 'Password must have at least 6 characters';
    else if (newPassword != originalPassword)
      return 'Passwords do not match';
    else
      return null;
  }

  static String? name(String? value, String key) {
    final regExp = RegExp(r"^[^0-9]+$");
    if (value == null || value.isEmpty)
      return '$key is required';
    else if (!regExp.hasMatch(value))
      return '$key cannot have numbers';
    else
      return null;
  }
}
