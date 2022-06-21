import 'package:basearch/src/features/home/domain/model/type_measure_model.dart';

class MeasureModel {
  final DateTime date;
  final String value;
  final TypeMeasureModel type;
  MeasureModel({required this.date, required this.type, required this.value});

  factory MeasureModel.fromJson(Map<dynamic, dynamic> json) => MeasureModel(
      value: json["value"],
      date: DateTime.parse(json['date']).toLocal(),
      type: TypeMeasureModel.fromJson(json["typeDTO"]));
  Map<String, dynamic> toJson() => {"date": date, "value": value, "type": type};
}
