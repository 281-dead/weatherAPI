import 'package:dio/dio.dart';

//
class DioClient {
  static final DioClient _dio = DioClient._internal();
  late Dio dio;

  DioClient._internal() {
    dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      baseUrl: 'https://api.openweathermap.org',
    ));
    dio.interceptors.add(LogInterceptor(request: true));
  }

  static DioClient get instance => _dio;
}
