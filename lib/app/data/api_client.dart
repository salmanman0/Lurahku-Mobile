import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApiClient extends GetConnect {
  static const String domain = 'http://192.168.1.5:5000';
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