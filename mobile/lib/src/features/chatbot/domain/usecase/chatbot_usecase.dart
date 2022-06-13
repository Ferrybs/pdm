import 'package:basearch/src/features/chatbot/data/dto/response_dto.dart';
import 'package:basearch/src/features/chatbot/domain/model/chatbot_message_response_model.dart';
import 'package:basearch/src/features/preference/domain/usecase/preference_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:localization/localization.dart';
import 'package:uuid/uuid.dart';

import '../../data/dto/person_dto.dart';
import '../model/chatbot_message_request_model.dart';
import '../model/client_model.dart';
import '../repository/chatbot_interface.dart';

class ChatbotUseCase {
  final _repository = Modular.get<IChatbot>();
  late ChatbotMessageResponseModel messageResponse;
  final _preference = Modular.get<PreferenceUsecase>();
  ResponseDTO? _responseDTO;

  Future<String?> sendText(String text, String date, String sessionId) async {
    try {
      ChatbotMessageRequestModel? messageRequest = ChatbotMessageRequestModel(
          text: text, date: date, sessionId: sessionId);
      ChatbotMessageResponseModel? responseModel;
      responseModel = (await _repository.sendText(
          messageRequest, await _preference.getAccessToken() ?? ''));

      messageResponse = responseModel;

      _responseDTO = ResponseDTO(messageResponse.date, messageResponse.text,
          messageResponse.suggestions);
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
    } catch (e) {
      return "server-error".i18n();
    }
  }

  Future<PersonDTO?> getClient() async {
    try {
      var token = await _preference.getAccessToken();
      ClientModel client = await _repository.getClient(token ?? '');
      PersonDTO person = PersonDTO(
          client.person.id, client.person.name, client.person.lastName);
      return person;
    } catch (e) {
      return null;
    }
  }

  ResponseDTO? get responseDTO {
    if (_responseDTO != null) {
      ResponseDTO response = _responseDTO!;
      return response;
    }
    return null;
  }
}
