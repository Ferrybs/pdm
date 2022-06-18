class TimeSeriesMeasureModel {
  final String value;
  final DateTime date;
  TimeSeriesMeasureModel({required this.value, required this.date});

  factory TimeSeriesMeasureModel.fromJson(Map<dynamic, dynamic> json) =>
      TimeSeriesMeasureModel(
          value: json["value"], date: DateTime.parse(json["date"].toString()));
  Map<String, dynamic> toJson() =>
      {"value": value, "date": date.toIso8601String()};
}
