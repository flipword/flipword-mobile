import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class RobohashHelper {
  RobohashHelper._privateConstructor() {
    dio ??= Dio(BaseOptions(
      baseUrl: 'https://robohash.org/',
    ));
  }

  Dio? dio;

  static final RobohashHelper _instance = RobohashHelper._privateConstructor();
  static RobohashHelper get instance => _instance;

  Future<FileImage> getAvatare(String? user) async {
    final directory = await getApplicationDocumentsDirectory();
    FileImage response;
    try {
      await dio!.download(
          user.hashCode.toString(), '${directory.path}avatar.png');
      final file = File('${directory.path}avatar.png');
      response = FileImage(file);
    } on SocketException catch (e) {
      throw Exception(e.message);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
    return response;
  }
}
