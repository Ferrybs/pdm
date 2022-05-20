import 'package:basearch/src/features/auth/domain/model/login_model.dart';
import 'package:basearch/src/features/auth/domain/model/person_model.dart';

class RegisterModel {
  final LoginModel? login;
  final PersonModel? person;

  RegisterModel({this.login, this.person});

  factory RegisterModel.fromJson(Map<dynamic, dynamic> json) => RegisterModel(
      person: PersonModel.fromJson(json["personDTO"]),
      login: LoginModel.fromJson(json["loginDTO"]));
  Map<String, dynamic> toJson() => {"loginDTO": login, "personDTO": person};
}
