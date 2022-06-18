import 'package:basearch/src/features/map/data/dto/device_dto.dart';
import 'package:basearch/src/features/map/data/dto/localization_dto.dart';

class DeviceLocalizationDTO {
  DeviceDTO deviceDTO;
  LocalizationDTO localizationDTO;
  DeviceLocalizationDTO(
      {required this.deviceDTO, required this.localizationDTO});
}
