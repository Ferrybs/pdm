extension ValidatorString on String {
  static final regxEmail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static final regxPassword = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}");
  static final regxPerson =
      RegExp(r"^[A-Za-z]+(((\'|\-|\.|\ )?([A-Za-z])+))?$");
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
