import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper{
  Dio dio;

  DioHelper._privateConstructor(){
    dio ??=Dio(BaseOptions(baseUrl: 'https://translation.googleapis.com/language/translate/v2'));
  }

  static final DioHelper _instance = DioHelper._privateConstructor();
  static DioHelper get instance => _instance;

  Future<dynamic> post(String route, [Map<String, dynamic> parametres]) async {
    dynamic responseJson;
    try {
      final response = await dio.post(route, queryParameters: parametres);
      responseJson = response.data;
    } on SocketException catch (e){
      throw Exception(e.message);
    } on DioError catch (e){
      throw Exception(e.message);
    }
    return responseJson;
  }

}