import 'package:dio/dio.dart';

class ChatbotRepositoryBase {
  final options = BaseOptions(
    baseUrl: "https://api-pdm-pia3.herokuapp.com/api/v1",
    connectTimeout: 5000,
  );
}
