import 'package:dio/dio.dart';

class Repository {
  final options = BaseOptions(
    baseUrl: "https://api-pdm-pia3.herokuapp.com/",
    connectTimeout: 5000,
  );
}
