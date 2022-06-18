import 'package:basearch/src/features/home/data/dto/chatbot_message_dto.dart';
import 'package:basearch/src/features/home/data/dto/chatbot_session_dto.dart';
import 'package:basearch/src/features/home/data/dto/device_dto.dart';
import 'package:basearch/src/features/home/domain/model/chatbot_session_model.dart';
import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/device_model.dart';
import 'package:basearch/src/features/preference/domain/usecase/preference_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:uuid/uuid.dart';
import '../repository/home_interface.dart';

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

  String? getPersonName() {
    return _clientModel?.person.name;
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
