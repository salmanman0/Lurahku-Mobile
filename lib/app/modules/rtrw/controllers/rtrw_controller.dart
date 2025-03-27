import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/api_service.dart'; // Adjust the import path as needed
import '../../../template/list_ketua.dart';

class RtrwController extends GetxController {
  var listKetua = <ListKetua>[].obs;
  var searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();
  final ApiService apiService = Get.put(ApiService()); // Initialize ApiService
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchKetuaData();
  }

  Future<void> fetchKetuaData() async {
    try {
      final token = box.read('token');
      final response = await apiService.getRtRw(token);

      if (response != null && response['status'] == 'sukses' && response['rtrw'] != null) {
        var data = List<Map<String, dynamic>>.from(response['rtrw']);
        var ketuaList = data.map((item) {
          return ListKetua(
            gambar: item['poto_profil'] ?? '',
            nama: item['nama'] ?? 'Nama tidak tersedia',
            jabatan: item['jabatan'] ?? 'Jabatan tidak tersedia',
            rt: item['rt'] ?? 'RT tidak tersedia',
            rw: item['rw'] ?? 'RW tidak tersedia',
            alamat: item['alamat'] ?? 'Alamat tidak tersedia',
            noHp: item['noHp'] ?? 'No HP tidak tersedia',
          );
        }).toList();
        listKetua.assignAll(ketuaList); 
      } else {
        print("Error fetching Ketua data: Invalid response");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  List<ListKetua> get filteredKetua {
    if (searchQuery.value.isEmpty) {
      return listKetua;
    } else {
      return listKetua.where((ketua) {
        final namaLower = ketua.nama.toLowerCase();
        final rtLower = ketua.rt.toLowerCase();
        final rt = 'rt $rtLower';
        final rwLower = ketua.rw.toLowerCase();
        final rw = 'rw $rwLower';
        final jabatanLower = ketua.jabatan.toLowerCase();
        final keteranganLower = jabatanLower == 'ketua rw' ? 'ketua rw $rwLower' : 'ketua rt $rtLower';
        return namaLower.contains(searchQuery.value.toLowerCase()) || 
               rt.contains(searchQuery.value.toLowerCase()) || 
               rw.contains(searchQuery.value.toLowerCase()) || 
               jabatanLower.contains(searchQuery.value.toLowerCase()) || 
               keteranganLower.contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
