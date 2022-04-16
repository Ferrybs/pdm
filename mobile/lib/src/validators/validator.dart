extension ValidatorString on String {
  static final regxEmail = RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");
  static final regxPassword =
      RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
  static final regxPerson =
      RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");
  bool isEmail() {
    return regxEmail.hasMatch(this);
  }

  bool isPassword() {
    return regxPassword.hasMatch(this);
  }

  bool isPerson() {
    return regxPerson.hasMatch(this);
  }
}
