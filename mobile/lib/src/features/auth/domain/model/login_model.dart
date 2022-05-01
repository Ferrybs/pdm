import 'package:basearch/src/features/auth/domain/model/client_model.dart';
import 'package:basearch/src/features/auth/domain/model/token_data_model.dart';

class LoginModel {
  final ClientModel? client;
  final TokenDataModel? tokenData;

  LoginModel({this.client, this.tokenData});

  factory LoginModel.fromJson(Map<dynamic, dynamic> json) => LoginModel(
      client: ClientModel.fromJson(json["clientDTO"]),
      tokenData: TokenDataModel.fromJson(json["tokenData"]));
  Map<String, dynamic> toJson() =>
      {"clientDTO": client?.toJson(), "tokenData": tokenData?.toJson()};
}
