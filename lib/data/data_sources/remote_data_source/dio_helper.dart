import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper{
  Dio dio;

  DioHelper._privateConstructor(){
    dio ??=Dio(BaseOptions(baseUrl: 'https://api.cognitive.microsofttranslator.com/'));
    dio.options.headers['Ocp-Apim-Subscription-Key'] = 'f17d36bddd844b1baa37940586038d3e';
    dio.options.headers["Ocp-Apim-Subscription-Region"] = 'francecentral';
  }

  static final DioHelper _instance = DioHelper._privateConstructor();
  static DioHelper get instance => _instance;

  Future<dynamic> translate(String from, String to, String word) async {
    var responseJson;
    var response;
    final Map<String, String> parameters = {
      'from': from,
      'to': to,
      'api-version': '3.0'
    };
    final data = [{'Text': word}];
    try {
      final responseJson = await dio.post('translate', queryParameters: parameters, data: data);
      response = TranslateResponse.fromJson(responseJson.data).translations.single.text;
    } on SocketException catch (e){
      throw Exception(e.message);
    } on DioError catch (e){
      throw Exception(e.message);
    }
    return response;
  }
}

class TranslateResponse {
  List<Translations> translations;

  TranslateResponse({this.translations});

  TranslateResponse.fromJson(List<dynamic> jsonList) {
    final json = jsonList.single;
    if (json['translations'] != null) {
      translations = new List<Translations>();
      json['translations'].forEach((v) {
        translations.add(new Translations.fromJson(v));
      });
    }
  }
}

class Translations {
  String text;
  String to;

  Translations({this.text, this.to});

  Translations.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    to = json['to'];
  }
}