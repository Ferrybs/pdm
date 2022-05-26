class WifiModel {
  WifiModel({this.ssid, this.password});
  final String? ssid;
  final String? password;

  factory WifiModel.fromJson(Map<String, dynamic> json) =>
      WifiModel(ssid: json["ssid"], password: json["password"]);

  Map<String, dynamic> toJson() => {"ssid": ssid, "password": password};
}
