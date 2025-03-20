import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApiClient extends GetConnect {
  static const String domain = 'https://kelurahan-limbungan.pocari.id';
  final box = GetStorage();
  
  @override
  void onInit() {
    httpClient.baseUrl = domain;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      String? token = getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
    super.onInit();
  }

  String? getToken() {
    String? token = box.read('token');
    return token;
  }
}