class Validators {
  static String email(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    if (value == null || !regExp.hasMatch(value))
      return 'Email address invalid';
    else
      return null;
  }
}
