class Validators {
  static String email(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.isEmpty)
      return 'Email address is required';
    else if (!regExp.hasMatch(value))
      return 'Email address is invalid';
    else
      return null;
  }

  static String password(String value) {
    if (value == null || value.isEmpty)
      return 'Password is required';
    else if (value.length < 5)
      return 'Password must have at least 6 characters';
    else
      return null;
  }
}
