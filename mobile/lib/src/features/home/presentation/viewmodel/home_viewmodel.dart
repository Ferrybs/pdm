import 'package:basearch/src/features/home/data/dto/chatbot_session_dto.dart';
import 'package:basearch/src/features/home/data/dto/device_dto.dart';
import 'package:basearch/src/features/home/data/dto/person_dto.dart';
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

  @action
  void updateClientName(String name) {
    personDTO.name = name;
  }

  @action
  void updateCurrentIndex(int idx) {
    if (idx == 3) {
      ObservableFuture(_usecase.logout());
    } else {
      currentIndex = idx;
    }
  }

  @action
  void updateError(String? value) {
    error = value;
  }

  @action
  void updateDeviceList(List<DeviceDTO> list) {
    devicelist = list;
  }

  @action
  void updateChatbotSession(List<ChatbotSessionDTO> list) {
    chatbotSessions = list;
  }

  getChartMeasure(deviceId, id) {
    return _usecase.getChartMeasure(deviceId, id);
  }

  getHomeData() async {
    String? errorLocal;
    errorLocal = await _usecase.getClientFromRepository() ?? errorLocal;
    updateError(errorLocal);
    String? name = _usecase.getPersonName();
    if (name != null) {
      await _usecase.getDevicesFromRepository();
      updateDeviceList(_usecase.getDevices() ?? []);
      updateClientName(name);
    } else {
      updateError("session-error-tittle".i18n());
      return;
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

  Future<void> onDeleteChatSession(String id) async {
    await _usecase.deleteChatbotSession(id);
  }

  Future<void> onDeleteDevice(String id) async {
    await _usecase.deleteDevice(id);
    Modular.to.navigate("/home/0");
  }

  onEditDevice() {
    Modular.to.navigate("/device/edit");
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

  void navigateToChatbot(String id) {
    Modular.to.navigate('/chatbot/' + id);
  }

  String getNewChatbotSessionID() {
    return _usecase.getNewChatbotSessionId();
  }

  void navigateToDevice() {
    Modular.to.pushNamed('/device/');
  }
}
