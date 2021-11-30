import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TranslateHelper {

  TranslateHelper._privateConstructor() {
    dio ??= Dio(
        BaseOptions(
            baseUrl: 'https://api.cognitive.microsofttranslator.com/'
        ));
    dio!
        .options
        .headers['Ocp-Apim-Subscription-Key'] = dotenv.env['AZURE_TRANSLATE_KEY'];

    dio!
        .options
        .headers['Ocp-Apim-Subscription-Region'] = 'francecentral';
  }

  Dio? dio;

  static final TranslateHelper _instance =
      TranslateHelper._privateConstructor();
  static TranslateHelper get instance => _instance;

  Future<String?> translate(String? from, String? to, String word) async {
    String? response;
    final parameters = <String, String?>{
      'from': from,
      'to': to,
      'api-version': '3.0'
    };
    final data = <Map<String, String>>[
      {'Text': word}
    ];
    try {
      final responseJson =
          await dio!.post('translate', queryParameters: parameters, data: data);
      response = TranslateResponse.fromJson(responseJson.data)
          .translations!
          .single
          .text;
    } on SocketException catch (e) {
      throw Exception(e.message);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return response;
  }
}

class TranslateResponse {
  TranslateResponse({this.translations});

  TranslateResponse.fromJson(dynamic jsonList) {
    final json = jsonList.single;
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((dynamic v) {
        translations!.add(Translations.fromJson(v));
      });
    }
  }



  List<Translations>? translations;


}

class Translations {
  Translations({this.text, this.to});
  Translations.fromJson(dynamic json) {
    text = json['text'].toString();
    to = json['to'].toString();
  }

  String? text;
  String? to;

}
