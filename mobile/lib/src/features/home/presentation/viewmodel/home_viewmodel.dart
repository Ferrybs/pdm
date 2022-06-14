import 'package:basearch/src/features/home/data/dto/chatbot_session_dto.dart';
import 'package:basearch/src/features/home/data/dto/device_dto.dart';
import 'package:basearch/src/features/home/domain/model/plant_stats_model.dart';
import 'package:basearch/src/features/home/data/dto/person_dto.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:localization/localization.dart';
import '../../domain/usecase/home_usecase.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store {
  final _usecase = Modular.get<HomeUseCase>();

  @observable
  PersonDTO personDTO = PersonDTO();

  @observable
  List<DeviceDTO> devicelist = [];

  @observable
  List<ChatbotSessionDTO> chatbotSessions = [];

  @observable
  int currentIndex = 1;

  @observable
  String? error;

  @observable
  List<PlantStatsModel> plantList = [];

  @action
  void updateClientName(String name) {
    personDTO.name = name;
  }

  @action
  void updateCurrentIndex(int idx) {
    currentIndex = idx;
  }

  @action
  void updateError(String? value) {
    error = value;
  }

  @action
  void updatePlantList(List<PlantStatsModel> list) {
    plantList = list;
  }

  @action
  void updateDeviceList(List<DeviceDTO> list) {
    devicelist = list;
  }

  @action
  void updateChatbotSession(List<ChatbotSessionDTO> list) {
    chatbotSessions = list;
  }

  getHomeData() async {
    String? errorLocal;
    errorLocal = await _usecase.getClientFromRepository() ?? errorLocal;
    updateError(errorLocal);
    String? name = _usecase.getPersonName();
    if (name != null) {
      updateClientName(name);
    } else {
      updateError("session-error-tittle".i18n());
      return;
    }
    List<PlantStatsModel>? list = await _usecase.getPlantList();
    if (list != null) {
      updatePlantList(list);
    }
  }

  getDeviceData() async {
    String? errorLocal;
    errorLocal = await _usecase.getDevicesFromRepository() ?? errorLocal;
    errorLocal = await _usecase.getClientFromRepository() ?? errorLocal;
    updateError(errorLocal);
    String? name = _usecase.getPersonName();
    if (name != null) {
      updateClientName(name);
    }
    List<DeviceDTO>? devices = _usecase.getDevices();
    if (devices != null) {
      updateDeviceList(devices);
    }
  }

  getChatData() async {
    String? errorLocal;
    errorLocal = await _usecase.getClientFromRepository() ?? errorLocal;
    errorLocal =
        await _usecase.getChatbotSessionsFromRepository() ?? errorLocal;
    updateError(errorLocal);
    String? name = _usecase.getPersonName();
    if (name != null) {
      updateClientName(name);
    }
    updateChatbotSession(_usecase.getChatbotSessions() ?? []);
  }

  String gethomeTittle() {
    if (personDTO.name != null) {
      return personDTO.name! + ", " + "home-tittle".i18n();
    } else {
      return "session-error-tittle".i18n();
    }
  }

  String getDevicehomeTittle() {
    if (personDTO.name != null) {
      return personDTO.name! + ", " + "home-device-tittle".i18n();
    } else {
      return "session-error-tittle".i18n();
    }
  }

  String getChathomeTittle() {
    if (personDTO.name != null) {
      return personDTO.name! + ", " + "home-chat-tittle".i18n();
    } else {
      return "session-error-tittle".i18n();
    }
  }

  void navigateToLogin() {
    Modular.to.navigate("/auth/");
  }

  void navigateToMap() {
    Modular.to.navigate('/map/');
  }

  void navigateToChatbot() {
    Modular.to.navigate('/chatbot/');
  }

  void navigateToDevice(String id) {
    Modular.to.navigate('/device/' + id);
  }
}
