import 'package:basearch/src/features/map/domain/model/map_localization_model.dart';
import 'package:basearch/src/features/map/domain/model/map_preferences_model.dart';

class DeviceMapModel {
  final String id;
  final MapLocalizationModel localization;
  final MapPreferencesModel preferences;

  DeviceMapModel(
      {required this.id,
      required this.localization,
      required this.preferences});

  factory DeviceMapModel.fromJson(Map<dynamic, dynamic> json) => DeviceMapModel(
      id: json["deviceId"],
      localization: MapLocalizationModel.fromJson(json["localizationDTO"]),
      preferences: MapPreferencesModel.fromJson(json["preferencesDTO"]));
  Map<String, dynamic> toJson() => {
        "id": id,
        "localizationDTO": localization.toJson(),
        "preferencesDTO": preferences.toJson()
      };
}
