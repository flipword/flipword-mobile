import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_helper.dart';
import 'package:flutter_flip_card/data/entities/secret.dart';

class TranslateHelper {
  TranslateHelper._privateConstructor();

  static const collectionName = 'keyStorage';
  late Dio dio;
  late Secret googleTranslateSecret;
  final FirestoreHelper _firestoreHelper = FirestoreHelper.instance;
  static final TranslateHelper _instance =
      TranslateHelper._privateConstructor();
  static TranslateHelper get instance => _instance;

  Future<void> init() async {
    try {
      final googleTranslateSecretQueryDocument = await _firestoreHelper
          .getCollection(collectionName)
          .where('keyId', isEqualTo: 'google_translate')
          .get()
          .then((querySnapshot) => querySnapshot.docs.first);
      googleTranslateSecret = Secret.fromJson(
          googleTranslateSecretQueryDocument.data() as Map<String, dynamic>);
      dio = Dio(
          BaseOptions(baseUrl: 'https://translation.googleapis.com/language'));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> translate(String? from, String? to, String word) async {
    String? response;
    final parameters = <String, String?>{
      'source': from,
      'target': to,
      'q': word,
      'key': googleTranslateSecret.value
    };
    try {
      final responseJson =
          await dio.post('/translate/v2', queryParameters: parameters);
      response = TranslateResponse.fromJson(responseJson.data).translation;
    } on SocketException catch (e) {
      throw Exception(e.message);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return response;
  }
}

class TranslateResponse {
  TranslateResponse({this.translation});

  TranslateResponse.fromJson(dynamic json) {
    final jsonData = json['data'];
    if (jsonData['translations'] != null &&
        jsonData['translations'].length != 0) {
      translation = jsonData['translations'][0]['translatedText'];
    }
  }

  String? translation;
}
