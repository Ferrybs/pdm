export default interface DeviceLocalizationPreferencesQuery{
    device_localization_deviceId: string,
    device_localization_latitude: number,
    device_localization_longitude: number,
    device_preferences_temperature: string,
    device_preferences_humidity: string,
    device_preferences_moisture: string,
    device_preferences_luminosity: string,
}