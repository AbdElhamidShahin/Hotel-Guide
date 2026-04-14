import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();
  Future<Response> post({
    required String url,
    required body,
    required String token,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    final mergedHeaders = {
      'Authorization': 'Bearer $token',
      ...?headers,
    };
    var response = await dio.post(
      url,
      data: body,
      options: Options(
        contentType: contentType,
        headers: mergedHeaders,
      ),
    );

    return response;
  }
}
