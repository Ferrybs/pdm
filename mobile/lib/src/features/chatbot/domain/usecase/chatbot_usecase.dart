import 'package:basearch/src/features/chatbot/data/dto/response_dto.dart';
import 'package:basearch/src/features/chatbot/domain/model/chatbot_message_response_model.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:uuid/uuid.dart';

import '../../data/dto/person_dto.dart';
import '../model/chatbot_message_request_model.dart';
import '../model/client_model.dart';
import '../repository/chatbot_interface.dart';

class ChatbotUseCase {
  final repository = Modular.get<IChatbot>();
  late ChatbotMessageResponseModel messageResponse;
  final encryptedPreferences = Modular.get<EncryptedSharedPreferences>();
  ResponseDTO? _responseDTO;

  Future<String?> sendText(String text, String date, String sessionId) async {
    try {
      ChatbotMessageRequestModel? messageRequest = ChatbotMessageRequestModel(
          text: text, date: date, sessionId: sessionId);

      if (messageRequest != null) {
        ChatbotMessageResponseModel? responseModel;
        responseModel = (await repository.sendText(messageRequest,
            await encryptedPreferences.getString("AccessToken")))!;

        messageResponse = responseModel;

        _responseDTO = ResponseDTO(messageResponse.date, messageResponse.text,
            messageResponse.suggestions);
      }

      return null;
    } on DioError catch (e) {
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 400:
            return "invalid-field".i18n();
          default:
            if (e.response?.data) {
              var data = e.response?.data;
              if (data["message"] != null) {
                return data["message"];
              }
            }
        }
      }
      return "server-error".i18n();
    }
  }

  Future<PersonDTO?> getClient() async {
    var token = await encryptedPreferences.getString("AccessToken");
    ClientModel? client = await repository.getClient(token);
    if (client != null) {
      PersonDTO person = PersonDTO(
          client.person.id, client.person.name, client.person.lastName);
      return person;
    }
    return null;
  }

  ResponseDTO? get responseDTO {
    if (_responseDTO != null) {
      ResponseDTO response = _responseDTO!;
      return response;
    }
    return null;
  }
}
