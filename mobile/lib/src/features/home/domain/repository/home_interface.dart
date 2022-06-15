import 'package:basearch/src/features/home/domain/model/chatbot_session_model.dart';
import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/device_model.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';

abstract class IHome {
  Future<List<PlantStatsModel>> getPlantStats();
  Future<ClientModel> getClient(String token);
  Future<List<DeviceModel>> getDevices(String token);
  Future<List<ChatbotSessionModel>> getChatbotSessions(String token);
  Future<bool> deleteChatBotSession(String token, String id);
}
