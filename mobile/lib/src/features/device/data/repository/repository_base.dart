import 'package:dio/dio.dart';

class DeviceRepositoryBase {
  final deviceOptions = BaseOptions(
    baseUrl: "https://device.free.beeceptor.com/",
    connectTimeout: 5000,
  );
}
