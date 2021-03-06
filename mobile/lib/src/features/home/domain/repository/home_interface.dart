import 'package:basearch/src/features/home/domain/model/chatbot_session_model.dart';
import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/device_measure_model.dart';
import 'package:basearch/src/features/home/domain/model/device_model.dart';
import 'package:basearch/src/features/home/domain/model/measure_model.dart';
import 'package:basearch/src/features/home/domain/model/measure_model_query.dart';
import 'package:basearch/src/features/home/domain/model/measure_preferences_model.dart';

abstract class IHome {
  Future<ClientModel> getClient(String token);
  Future<List<DeviceModel>> getDevices(String token);
  Future<List<ChatbotSessionModel>> getChatbotSessions(String token);
  Future<bool> deleteChatBotSession(String token, String id);
  Future<bool> deleteDevice(String token, String id);
  Future<List<MeasureModel>> getMeasures(MeasureQueryModel query, String token);
  Future<bool> setMeasurePreferences(
      MeasurePreferencesModel measurePrefs, String token);
  Future<DevicePreferencesModel> getMeasureValues(
      DeviceModel device, String token);
}
