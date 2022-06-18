import 'dart:async';

import 'package:basearch/src/features/home/data/repository/home_repository_base.dart';
import 'package:basearch/src/features/home/domain/model/chatbot_session_model.dart';
import 'package:basearch/src/features/home/domain/model/client_model.dart';
import 'package:basearch/src/features/home/domain/model/device_measure_model.dart';
import 'package:basearch/src/features/home/domain/model/device_model.dart';
import 'package:basearch/src/features/home/domain/model/measure_model_query.dart';
import 'package:basearch/src/features/home/domain/model/measure_model.dart';
import 'package:basearch/src/features/home/domain/model/measure_preferences_model.dart';
import 'package:basearch/src/main.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/home_interface.dart';

class HomeRepository extends HomeRepositoryBase implements IHome {
  @override
  Future<ClientModel> getClient(String token) async {
    try {
      Response response;
      var dio = Dio(apiOptions);
      response = await dio.get("/client/",
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return ClientModel.fromJson(response.data["clientDTO"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DeviceModel>> getDevices(String token) async {
    try {
      Response response;
      var dio = Dio(apiOptions);
      response = await dio.get("/device",
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return (response.data['deviceDTO'] as List)
          .map((device) => DeviceModel.fromJson(device))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ChatbotSessionModel>> getChatbotSessions(String token) async {
    try {
      Response response;
      var dio = Dio(apiOptions);
      response = await dio.get("/chatbot",
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return (response.data['chatbotSessionsDTO'] as List)
          .map((session) => ChatbotSessionModel.fromJson(session))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteChatBotSession(String token, String id) async {
    try {
      Response response;
      var dio = Dio(apiOptions);
      response = await dio.delete("/chatbot/" + id,
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return response.data['ok'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteDevice(String token, String id) async {
    try {
      Response response;
      var dio = Dio(apiOptions);
      response = await dio.delete("/device/" + id,
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return response.data['ok'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MeasureModel>> getMeasures(
      MeasureQueryModel query, String token) async {
    try {
      Response response;
      var dio = Dio(apiOptions);
      response = await dio.post("/device/measure",
          data: query.toJson(),
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return (response.data['measureDTO'] as List)
          .map((e) => MeasureModel.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> setMeasurePreferences(
      MeasurePreferencesModel measurePrefs, String token) async {
    try {
      Response response;
      var dio = Dio(apiOptions);
      response = await dio.post("/device/preferences",
          data: measurePrefs.toJson(),
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DevicePreferencesModel> getMeasureValues(
      DeviceModel device, String token) async {
    try {
      Response response;
      print(device.toJson());
      var dio = Dio(apiOptions);
      response = await dio.get("/device/preferences/" + device.id,
          options: Options(headers: {"Authorization": "Bearer " + token}));
      return DevicePreferencesModel.fromJson(
          response.data['devicePreferencesDTO']);
    } catch (e) {
      rethrow;
    }
  }
}
