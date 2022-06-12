import DevicePreferences from "../../../features/device/entities/device.preferences.entity";
import DeviceLocalization from "../../../features/device/entities/device.localization.entity";
import Measure from "../../../features/device/entities/measure.entity";
import Device from "../../../features/device/entities/device.entity";

export default interface MqttDatabase{
    saveDeviceLocalization(deviceLocalization: DeviceLocalization): Promise<DeviceLocalization>;
    saveDevicePreferences(devicePreferences: DevicePreferences): Promise<DevicePreferences>;
    insertMeasure(measure: Measure): Promise<Measure>;
    saveDevice(device: Device): Promise<Device>;
}