import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
        '[Dio] Solicitud enviada: ${options.method} ${options.uri} - ${options.headers}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[Dio] Respuesta recibida: ${response.statusCode} ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
        '[Dio] Error ocurrido: ${err.response?.statusCode} Mensaje: ${err.message}');
    if (err.response?.statusCode == 401) {
      print('[Dio] Sesión expirada. Redirigir al inicio de sesión.');
    }
    super.onError(err, handler);
  }
}
