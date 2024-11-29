import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Dio dio;
  setUp(() async {
    dio = Dio();
  });

  test('[Unitaria]: Prueba de servicio"', () async {
    print(
        "Realizando la llamada al servicio de https://jsonblob.com/api/1151549092634943488");
    final response =
        await dio.get("https://jsonblob.com/api/1151549092634943488");
    expect(response.statusCode, HttpStatus.ok);
    expect(response.data, isNotNull);
    expect(response.data, isNotEmpty);
  });
}
