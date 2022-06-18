class MqttModel {
  MqttModel(
      {required this.server,
      required this.user,
      required this.password,
      required this.port});
  final String server;
  final String user;
  final String password;
  final String port;

  factory MqttModel.fromJson(Map<String, dynamic> json) => MqttModel(
      server: json["server"],
      user: json["user"],
      password: json["password"],
      port: json["port"]);

  Map<String, dynamic> toJson() => {
        '"server"': '"' + server + '"',
        '"user"': '"' + user + '"',
        "password": '"' + password + '"',
        "port": '"' + port + '"'
      };
}
