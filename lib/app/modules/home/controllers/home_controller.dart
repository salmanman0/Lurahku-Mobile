import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/api_service.dart';
import '../../datadiri/controllers/datadiri_controller.dart';

class HomeController extends GetxController {
  DatadiriController dController = Get.put(DatadiriController());

  var domainUrl = "http://192.168.1.19:5000";
  // var domainUrl = "http://192.168.1.13:5000";
  final box = GetStorage();
  var token = ''.obs;
  final apiService = Get.put(ApiService());
  var selectedIndex = 0.obs;
  var userData = {}.obs;
  
  RxBool isLoading = false.obs;

  RxList indexPage = [].obs;
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Future<void> getUser() async {
    try {
      isLoading.value = true;
      final token = box.read('token');
      if (token == null) {
        print('Token tidak ditemukan!');
        return;
      }
      var responseData = await apiService.getUser(token);
      if (responseData != null) {
        var data = responseData['users'];
        userData.value ={
          "email" : data['email']?? "",
          "alamat" : data['alamat']?? "",
          "gambar_kk" : data['gambar_kk']?? "",
          "jabatan" : data['jabatan']?? "",
          "noHp" : data['noHp']?? "",
          "noKK" : data['noKK']?? "",
          "password" : data['password']?? "",
          "poto_profil" : data['poto_profil']?? "",
          "rt" : data['rt']?? "",
          "rw" : data['rw']?? "",
          "uId" : data['uId']?? "",
        };
      } else {
        print('Gagal mendapatkan data pengguna');
      }
    } catch (e) {
      print('Error saat mendapatkan data: $e');
    }
    finally{
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }
}
