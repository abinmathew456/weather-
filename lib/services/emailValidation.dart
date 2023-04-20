
class EmailValidation  {

  static validateEmailAddress(String input) {
    const emailRegex =
    r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    if (RegExp(emailRegex).hasMatch(input)) {
      return true;
    } else {
      return false;
    }
  }

}

