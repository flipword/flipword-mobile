import 'package:dio/dio.dart';

class RobohashHelper {
  RobohashHelper._privateConstructor() {
    dio ??= Dio(BaseOptions(
      baseUrl: 'https://robohash.org/',
    ));
  }

  Dio dio;

  static String get _baseUrl => 'https://robohash.org/';
  static final RobohashHelper _instance = RobohashHelper._privateConstructor();
  static RobohashHelper get instance => _instance;

  Future<String> getAvatarPath(String user) async {
    return '$_baseUrl${user.hashCode.toString()}';
  }
}
