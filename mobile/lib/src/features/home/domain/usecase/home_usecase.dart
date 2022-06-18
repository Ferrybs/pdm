import 'package:basearch/src/features/home/data/dto/chatbot_message_dto.dart';
import 'package:basearch/src/features/home/data/dto/chatbot_session_dto.dart';
import 'package:basearch/src/features/home/data/dto/device_dto.dart';
import 'package:basearch/src/features/home/domain/model/chatbot_session_model.dart';
import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/device_model.dart';
import 'package:basearch/src/features/home/domain/model/measure_model.dart';
import 'package:basearch/src/features/home/domain/model/measure_model_query.dart';
import 'package:basearch/src/features/home/domain/model/measure_preferences_model.dart';
import 'package:basearch/src/features/home/domain/model/time_series_measure_model.dart';
import 'package:basearch/src/features/preference/domain/usecase/preference_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:uuid/uuid.dart';
import '../repository/home_interface.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeUseCase {
  final repository = Modular.get<IHome>();
  final _preference = Modular.get<PreferenceUsecase>();
  ClientModel? _clientModel;
  List<DeviceModel>? _deviceModelList;
  List<ChatbotSessionModel>? _chatbotSessionList;

  String getNewChatbotSessionId() {
    return const Uuid().v4();
  }

  logout() async {
    await _preference.logout();
    Modular.to.navigate('/auth/');
  }

  List<bool> selectChart(index, List<bool> activeChart) {
    for (var i = 0; i < 4; i++) {
      if (i == index) {
        activeChart[i] = true;
      } else {
        activeChart[i] = false;
      }
    }
    return activeChart;
  }

  String? getPersonName() {
    return _clientModel?.person.name;
  }

  Future<void> setPreferences(
      List<double> measurePreference, DeviceDTO deviceDTO) async {
    try {
      String? token = await _preference.getAccessToken();
      final measurePrefs = MeasurePreferencesModel(
          temperature: measurePreference[0].toString(),
          humidity: measurePreference[1].toString(),
          luminosity: measurePreference[2].toString(),
          moisture: measurePreference[3].toString(),
          device: DeviceModel(id: deviceDTO.id, name: deviceDTO.name));
      repository.setMeasurePreferences(measurePrefs, token ?? '');
    } catch (e) {
      return;
    }
  }

  Future<List<double>> getMeasureValues(DeviceDTO deviceDTO) async {
    List<double> measurePreferences = [0, 0, 0, 0];
    try {
      String? token = await _preference.getAccessToken();
      final deviceMeasure = await repository.getMeasureValues(
          DeviceModel(id: deviceDTO.id, name: deviceDTO.name), token ?? "");
      measurePreferences[0] = double.parse(deviceMeasure.temperature);
      measurePreferences[1] = double.parse(deviceMeasure.humidity);
      measurePreferences[2] = double.parse(deviceMeasure.luminosity);
      measurePreferences[3] = double.parse(deviceMeasure.moisture);
    } catch (e) {
      return measurePreferences;
    }
    return measurePreferences;
  }

  Future<String?> getClientFromRepository() async {
    try {
      String? token = await _preference.getAccessToken();
      if (token != null) {
        _clientModel = await repository.getClient(token);
      } else {
        return "session-error-tittle".i18n();
      }
      if (_clientModel != null) {
        return null;
      } else {
        return "session-error-tittle".i18n();
      }
    } on DioError {
      return "session-error-tittle".i18n();
    } catch (e) {
      return "session-error-tittle".i18n();
    }
  }

  Future<List<MeasureModel>> getMeasures(String deviceId) async {
    try {
      final now = DateTime.now();
      String? token = await _preference.getAccessToken();
      MeasureQueryModel query = MeasureQueryModel(
          start: DateTime(now.year, now.month, now.day - 5),
          end: DateTime(now.year, now.month, now.day),
          deviceId: deviceId);
      final measures = await repository.getMeasures(query, token ?? '');
      return measures;
    } catch (e) {
      return [];
    }
  }

  Future<List<charts.Series<TimeSeriesMeasureModel, DateTime>>> getChartMeasure(
      String deviceId, String chartName, String index) async {
    List<MeasureModel> measures = [];
    final List<TimeSeriesMeasureModel> data = [];
    try {
      measures = await getMeasures(deviceId);
    } catch (e) {
      return [];
    }
    for (var e in measures) {
      if (e.type.id.trim() == index.trim()) {
        data.add(TimeSeriesMeasureModel(value: e.value, date: e.date));
      }
    }
    return [
      charts.Series<TimeSeriesMeasureModel, DateTime>(
        data: data,
        id: chartName,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesMeasureModel measure, _) => measure.date,
        measureFn: (TimeSeriesMeasureModel measure, _) =>
            num.parse(measure.value),
      )
    ];
  }

  Future<String?> getDevicesFromRepository() async {
    try {
      String? token = await _preference.getAccessToken();
      if (token != null) {
        _deviceModelList = await repository.getDevices(token);
      } else {
        return "session-error-tittle".i18n();
      }
      return null;
    } catch (e) {
      return "server-error".i18n();
    }
  }

  Future<String?> getChatbotSessionsFromRepository() async {
    try {
      String? token = await _preference.getAccessToken();
      if (token != null) {
        _chatbotSessionList = await repository.getChatbotSessions(token);
      } else {
        return "session-error-tittle".i18n();
      }
      return null;
    } catch (e) {
      return "server-error".i18n();
    }
  }

  List<DeviceDTO>? getDevices() {
    return _deviceModelList?.map((device) {
      return DeviceDTO(id: device.id, name: device.name);
    }).toList();
  }

  List<ChatbotSessionDTO>? getChatbotSessions() {
    return _chatbotSessionList?.map((session) {
      return ChatbotSessionDTO(
          id: session.id,
          chatbotMessageDTO: ChatbotMessageDTO(
              message: session.message[session.message.length - 1].message,
              date: session.message[session.message.length - 1].date));
    }).toList();
  }

  Future<String?> deleteChatbotSession(String id) async {
    try {
      String? token = await _preference.getAccessToken();
      if (token != null) {
        await repository.deleteChatBotSession(token, id);
      } else {
        return "server-error".i18n();
      }
      return null;
    } catch (e) {
      return "server-error".i18n();
    }
  }

  Future<String?> deleteDevice(String id) async {
    try {
      String? token = await _preference.getAccessToken();
      if (token != null) {
        await repository.deleteDevice(token, id);
      } else {
        return "server-error".i18n();
      }
      return null;
    } catch (e) {
      return "server-error".i18n();
    }
  }
}
