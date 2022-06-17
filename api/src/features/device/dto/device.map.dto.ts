import DevicePreferencesDTO from "./device.preferences.dto";
import LocalizationDTO from "./localization.dto";
import PreferencesDTO from "./preferences.dto";

export default class DeviceMapDTO {
    deviceId?: string; 
    localizationDTO?: LocalizationDTO
    preferencesDTO?: PreferencesDTO; 
}