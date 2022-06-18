class MeasureQueryModel {
  final String deviceId;
  final DateTime start;
  final DateTime end;
  MeasureQueryModel(
      {required this.start, required this.end, required this.deviceId});

  factory MeasureQueryModel.fromJson(Map<dynamic, dynamic> json) =>
      MeasureQueryModel(
          deviceId: json["deviceId"], start: json["start"], end: json["end"]);
  Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "start": start.toIso8601String(),
        "end": end.toIso8601String()
      };
}
