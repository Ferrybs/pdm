extension ValidatorString on String {
  static final regxEmail = RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");
  bool isEmail() {
    return regxEmail.hasMatch(this);
  }
}
