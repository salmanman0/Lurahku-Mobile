import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:translator/translator.dart';

import '../../../data/api_service.dart';
import '../../../routes/app_pages.dart';
import '../../../template/color_app.dart';

class BerandaController extends GetxController {
  final apiService = Get.put(ApiService());
  final box = GetStorage();
  final translator = GoogleTranslator();
  var weatherData = {}.obs;
  var isLoading = true.obs;
  var wheater = true.obs;
  var tanggal = ''.obs;
  var warn1 = ''.obs;
  var kebenaran1 = false.obs;
  var warn2 = ''.obs;
  var kebenaran2 = false.obs;

  final RxList<Map<String, dynamic>> keluarga = <Map<String, dynamic>>[].obs;

  final nikTerlaporController = TextEditingController();
  final kewarganegaraanTerlaporController = TextEditingController();

  final hariMeninggalController = TextEditingController();
  final pukulMeninggalController = TextEditingController();
  final tempatMeninggalController = TextEditingController();
  final penyebabMeninggalController = TextEditingController();

  final nikPelaporController = TextEditingController();
  final kewarganegaraanPelaporController = TextEditingController();
  final hubunganPelaporController = TextEditingController();

  final bulanHilangController = TextEditingController();
  final tahunHilangController = TextEditingController();

  final alamatCustomController = TextEditingController();
  final tempatLahirCustomController = TextEditingController();
  final namaCustomController = TextEditingController();
  final agamaCustomController = TextEditingController();
  final pekerjaanCustomController = TextEditingController();
  final jabatanCustomController = TextEditingController();
  final rtCustomController = TextEditingController();
  final rwCustomController = TextEditingController();
  final noHpCustomController = TextEditingController();

  final namaPerusahaanController = TextEditingController();
  final namaNotarisController = TextEditingController();
  final noAktaController = TextEditingController();

  final jenisUsahaController = TextEditingController();

  final penghasilanController = MoneyMaskedTextController(
    decimalSeparator: '', // Tidak perlu separator desimal
    thousandSeparator: '.', // Gunakan titik untuk separator ribuan
    precision: 0, // Tidak perlu desimal untuk format penghasilan
    initialValue: 0,
  );
  final keteranganDialogController = TextEditingController();

  var checkboxItems = [].obs;
  var checkboxValues = <RxBool>[].obs;

  var selectedDokumenBenar = "KTP".obs;
  var selectedDokumenSalah = "KTP".obs;

  var namaDokumenBenarController = TextEditingController();
  var nomorDokumenBenarController = TextEditingController();
  var dataBenarController = TextEditingController();

  var namaDokumenSalahController = TextEditingController();
  var nomorDokumenSalahController = TextEditingController();
  var dataSalahController = TextEditingController();

  var nomorSPKTPController = TextEditingController();

  Future<void> logout() async {
    final token = box.read('token');
    await apiService.logout(token);
    await box.erase();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<String> translateText(String text) async {
    var translation = await translator.translate(text, from: 'en', to: 'id');
    return translation.text;
  }

  String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    return DateFormat('d MMMM y HH:mm', 'id_ID').format(dateTime);
  }

  Future<void> fetchWeatherData() async {
    String apiKey = 'f034ad1b1aa24b55af273735241809';
    String location = 'Pekanbaru';
    String url =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location';
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String conditionText =
            await translateText(data['current']['condition']['text']);

        weatherData.value = {
          'name': data['location']['name'],
          'region': data['location']['region'],
          'localtime': data['location']['localtime'],
          'conditionText': conditionText,
          'conditionIcon': data['current']['condition']['icon'],
          'temperature': data['current']['temp_c']
        };
      }
    } catch (e) {
      wheater.value = false;
      print("Error fetching weather data: $e");
    } finally {
      isLoading(false);
    }
  }

  void setTanggal(DateTime pickedDate) {
    final DateFormat formatter = DateFormat("dd MMMM yyyy");
    tanggal.value = formatter.format(pickedDate);
  }

  Future<void> postSuketKematian() async {
    final token = box.read('token');
    var nikT = nikTerlaporController.text;
    var kewarganegaraanT = kewarganegaraanTerlaporController.text;
    var hariHM = hariMeninggalController.text;
    var tanggalHM = tanggal.value;
    var pukulHM = pukulMeninggalController.text;
    var bertempatHM = tempatMeninggalController.text;
    var penyebabHM = penyebabMeninggalController.text;
    var nikP = nikPelaporController.text;
    var hubunganP = hubunganPelaporController.text;
    var keteranganP = keteranganDialogController.text;
    if (nikT.isEmpty ||
        kewarganegaraanT.isEmpty ||
        hariHM.isEmpty ||
        tanggalHM.isEmpty ||
        pukulHM.isEmpty ||
        bertempatHM.isEmpty ||
        penyebabHM.isEmpty ||
        nikP.isEmpty ||
        hubunganP.isEmpty ||
        keteranganP.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Pastikan seluruh kolom terisi dengan baik',
        backgroundColor: Colors.yellow.withOpacity(0.2),
        colorText: black,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      if (nikT.length < 16 && nikP.length < 16) {
        kebenaran1.value = true;
        kebenaran2.value = true;
        warn1.value = "NIK kurang dari 16 digit";
        warn2.value = "NIK kurang dari 16 digit";
      } else if (nikP.length < 16) {
        kebenaran1.value = false;
        kebenaran2.value = true;
        warn1.value = "";
        warn2.value = "NIK kurang dari 16 digit";
      } else if (nikT.length < 16) {
        kebenaran1.value = true;
        kebenaran2.value = false;
        warn1.value = "NIK kurang dari 16 digit";
        warn2.value = "";
      } else {
        try {
          isLoading.value = true;
          final response = await apiService.postSuketKematian(
              token,
              nikT,
              kewarganegaraanT,
              hariHM,
              tanggalHM,
              pukulHM,
              bertempatHM,
              penyebabHM,
              nikP,
              hubunganP,
              keteranganP);
          if (response != null && response['status'] == 'sukses') {
            Get.snackbar(
              'Sukses',
              response['message'] ??
                  'Permohonan Surat Kematian telah dikirimkan',
              backgroundColor: Colors.green.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            Get.snackbar(
              'Gagal',
              response?['message'] ??
                  'Permohonan Surat Kematian gagal dikirimkan',
              backgroundColor: Colors.red.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan: ${e.toString()}',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: black,
            snackPosition: SnackPosition.TOP,
          );
        } finally {
          nikTerlaporController.clear();
          kewarganegaraanTerlaporController.clear();
          hariMeninggalController.clear();
          tanggal.value = "";
          pukulMeninggalController.clear();
          tempatMeninggalController.clear();
          penyebabMeninggalController.clear();
          nikPelaporController.clear();
          hubunganPelaporController.clear();
          keteranganDialogController.clear();
          isLoading.value = false;
        }
        kebenaran1.value = false;
        kebenaran2.value = false;
        warn1.value = '';
        warn2.value = '';
      }
    }
    print(kebenaran1);
  }

  Future<void> postSuketPenghasilan() async {
    final token = box.read('token');
    var nikP = nikPelaporController.text;
    var penghasilanP = penghasilanController.text;
    var keteranganP = keteranganDialogController.text;
    if (nikP.isEmpty || penghasilanP.isEmpty || keteranganP.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Pastikan seluruh kolom terisi dengan baik',
        backgroundColor: Colors.yellow.withOpacity(0.2),
        colorText: black,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      if (nikP.length < 16) {
        kebenaran1.value = true;
        warn1.value = "NIK kurang dari 16 digit";
      } else {
        try {
          isLoading.value = true;
          final response = await apiService.postSuketPenghasilan(
              token, nikP, penghasilanP, keteranganP);
          if (response != null && response['status'] == 'sukses') {
            Get.snackbar(
              'Sukses',
              response['message'] ??
                  'Permohonan Surat Penghasilan telah dikirimkan',
              backgroundColor: Colors.green.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            Get.snackbar(
              'Gagal',
              response?['message'] ??
                  'Permohonan Surat Penghasilan gagal dikirimkan',
              backgroundColor: Colors.red.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan silahkan coba lagi',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: black,
            snackPosition: SnackPosition.TOP,
          );
        } finally {
          nikPelaporController.clear();
          penghasilanController.clear();
          keteranganDialogController.clear();
          isLoading.value = false;
        }
        kebenaran1.value = false;
        warn1.value = "";
      }
    }
  }

  Future<void> postSuketTidakMampu() async {
    final token = box.read('token');
    var nikP = nikPelaporController.text;
    var keteranganP = keteranganDialogController.text;
    if (nikP.isEmpty || keteranganP.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Pastikan seluruh kolom terisi dengan baik',
        backgroundColor: Colors.yellow.withOpacity(0.2),
        colorText: black,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      if (nikP.length < 16) {
        kebenaran1.value = true;
        warn1.value = "NIK kurang dari 16 digit";
      } else {
        try {
          isLoading.value = true;
          final response =
              await apiService.postSuketTidakMampu(token, nikP, keteranganP);
          if (response != null && response['status'] == 'sukses') {
            Get.snackbar(
              'Sukses',
              response['message'] ??
                  'Permohonan Surat Tidak Mampu telah dikirimkan',
              backgroundColor: Colors.green.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            Get.snackbar(
              'Gagal',
              response?['message'] ??
                  'Permohonan Surat Tidak Mampu gagal dikirimkan',
              backgroundColor: Colors.red.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan silahkan coba lagi',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: black,
            snackPosition: SnackPosition.TOP,
          );
        } finally {
          nikPelaporController.clear();
          penghasilanController.clear();
          keteranganDialogController.clear();
          isLoading.value = false;
        }
        kebenaran1.value = false;
        warn1.value = "";
      }
    }
  }

  Future<void> postSuketGaib() async {
    final token = box.read('token');
    var nikP = nikPelaporController.text;
    var nikT = nikTerlaporController.text;
    var wargaNegaraT = kewarganegaraanTerlaporController.text;
    var wargaNegaraP = kewarganegaraanPelaporController.text;
    var hubunganP = hubunganPelaporController.text;
    var keteranganP = keteranganDialogController.text;
    var bulanHilang = bulanHilangController.text;
    var tahunHilang = tahunHilangController.text;
    if (nikP.isEmpty || keteranganP.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Pastikan seluruh kolom terisi dengan baik',
        backgroundColor: Colors.yellow.withOpacity(0.2),
        colorText: black,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      if (nikT.length < 16 && nikP.length < 16) {
        kebenaran1.value = true;
        kebenaran2.value = true;
        warn1.value = "NIK kurang dari 16 digit";
        warn2.value = "NIK kurang dari 16 digit";
      } else if (nikP.length < 16) {
        kebenaran1.value = false;
        kebenaran2.value = true;
        warn1.value = "";
        warn2.value = "NIK kurang dari 16 digit";
      } else if (nikT.length < 16) {
        kebenaran1.value = true;
        warn1.value = "NIK kurang dari 16 digit";
        kebenaran2.value = false;
        warn2.value = "";
      } else {
        try {
          isLoading.value = true;
          final response = await apiService.postSuketGaib(
              token,
              nikP,
              nikT,
              wargaNegaraP,
              wargaNegaraT,
              hubunganP,
              keteranganP,
              bulanHilang,
              tahunHilang);
          if (response != null && response['status'] == 'sukses') {
            Get.snackbar(
              'Sukses',
              response['message'] ??
                  'Permohonan Surat Keterangan Gaib telah dikirimkan',
              backgroundColor: Colors.green.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            Get.snackbar(
              'Gagal',
              response?['message'] ??
                  'Permohonan Surat Keterangan Gaib gagal dikirimkan',
              backgroundColor: Colors.red.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan silahkan coba lagi',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: black,
            snackPosition: SnackPosition.TOP,
          );
        } finally {
          nikPelaporController.clear();
          nikTerlaporController.clear();
          kewarganegaraanPelaporController.clear();
          kewarganegaraanTerlaporController.clear();
          bulanHilangController.clear();
          tahunHilangController.clear();
          hubunganPelaporController.clear();
          keteranganDialogController.clear();
          isLoading.value = false;
        }
        kebenaran1.value = false;
        warn1.value = "";
        kebenaran2.value = false;
        warn2.value = "";
      }
    }
  }

  Future<void> postSuketOrangYangSama() async {
    final token = box.read('token');
    var nikP = nikPelaporController.text;
    var dokumenBenar = selectedDokumenBenar.value;
    var dokumenSalah = selectedDokumenSalah.value;
    var nomorDokumenBenar = nomorDokumenBenarController.text;
    var nomorDokumenSalah = nomorDokumenSalahController.text;
    var dataBenar = dataBenarController.text;
    var dataSalah = dataSalahController.text;
    var keteranganP = keteranganDialogController.text;

    if (nikP.isEmpty ||
        keteranganP.isEmpty ||
        dokumenBenar.isEmpty ||
        dokumenSalah.isEmpty ||
        nomorDokumenBenar.isEmpty ||
        nomorDokumenSalah.isEmpty ||
        dataBenar.isEmpty ||
        dataSalah.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Pastikan seluruh kolom terisi dengan baik',
        backgroundColor: Colors.yellow.withOpacity(0.2),
        colorText: black,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      if (nikP.length < 16) {
        kebenaran1.value = true;
        warn1.value = "NIK kurang dari 16 digit";
      } else if (nikP.length < 16) {
        kebenaran1.value = false;
        warn1.value = "";
      } else {
        try {
          if(dokumenBenar == "Lainnya"){
            dokumenBenar = namaDokumenBenarController.text;
          }
          if(dokumenSalah == "Lainnya"){
            dokumenSalah = namaDokumenSalahController.text;
          }
          isLoading.value = true;
          final response = await apiService.postSuketOrangYangSama(
              token,
              nikP,
              dokumenBenar,
              dokumenSalah,
              nomorDokumenBenar,
              nomorDokumenSalah,
              dataBenar,
              dataSalah,
              keteranganP);
          if (response != null && response['status'] == 'sukses') {
            Get.snackbar(
              'Sukses',
              response['message'] ?? 'Permohonan Surat Keterangan Orang Yang Sama telah dikirimkan',
              backgroundColor: Colors.green.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            Get.snackbar(
              'Gagal',
              response?['message'] ?? 'Permohonan Surat Keterangan Orang Yang Sama gagal dikirimkan',
              backgroundColor: Colors.red.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan silahkan coba lagi',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: black,
            snackPosition: SnackPosition.TOP,
          );
        } finally {
          nikPelaporController.clear();
          namaDokumenBenarController.clear();
          namaDokumenSalahController.clear();
          nomorDokumenBenarController.clear();
          nomorDokumenSalahController.clear();
          dataBenarController.clear();
          dataSalahController.clear();
          keteranganDialogController.clear();
          isLoading.value = false;
        }
        kebenaran1.value = false;
        warn1.value = "";
      }
    } 
  }

  // Future<void> postSuketDomisili() async {
  //   final token = box.read('token');
  //   var nikP = nikPelaporController.text;
  //   var kewarganegaraanP = kewarganegaraanPelaporController.text;
  //   var keteranganP = keteranganDialogController.text;
  //   if(nikP.isEmpty || keteranganP.isEmpty || kewarganegaraanP.isEmpty){
  //     Get.snackbar(
  //         'Perhatian',
  //         'Pastikan seluruh kolom terisi dengan baik',
  //         backgroundColor: Colors.yellow.withOpacity(0.2),
  //         colorText: black,
  //         snackPosition: SnackPosition.TOP,
  //       );
  //   }
  //   else{
  //     if (nikP.length < 16){
  //       kebenaran1.value = true;
  //       warn1.value = "NIK kurang dari 16 digit";
  //     }
  //     else {
  //       try {
  //         isLoading.value = true;
  //         final response = await apiService.postSuketDomisili(token, nikP, kewarganegaraanP,keteranganP);
  //         if (response != null && response['status'] == 'sukses') {
  //           Get.snackbar(
  //             'Sukses',
  //             response['message'] ?? 'Permohonan Surat Tidak Mampu telah dikirimkan',
  //             backgroundColor: Colors.green.withOpacity(0.2),
  //             colorText: black,
  //             snackPosition: SnackPosition.TOP,
  //           );
  //         } else {
  //           Get.snackbar(
  //             'Gagal',
  //             response?['message'] ?? 'Permohonan Surat Tidak Mampu gagal dikirimkan',
  //             backgroundColor: Colors.red.withOpacity(0.2),
  //             colorText: black,
  //             snackPosition: SnackPosition.TOP,
  //           );
  //         }
  //       } catch (e) {
  //         Get.snackbar(
  //           'Error',
  //           'Terjadi kesalahan silahkan coba lagi',
  //           backgroundColor: Colors.red.withOpacity(0.2),
  //           colorText: black,
  //           snackPosition: SnackPosition.TOP,
  //         );
  //       } finally {
  //         nikPelaporController.clear();
  //         kewarganegaraanPelaporController.clear();
  //         keteranganDialogController.clear();
  //         isLoading.value = false;
  //       }
  //       kebenaran1.value = false;
  //       warn1.value = "";
  //     }
  //   }
  // }
  Future<void> getKeluarga() async {
    final token = box.read('token');
    try {
      checkboxItems.clear();
      checkboxValues.clear();
      keluarga.clear();

      final response = await apiService.getKeluarga(token);
      if (response != null && response['status'] == 'sukses') {
        keluarga.assignAll(List<Map<String, dynamic>>.from(response['keluarga']));

        // Update checkbox items dan values
        checkboxItems.addAll(keluarga.map((e) => e['nama']));
        checkboxValues.addAll(List.generate(keluarga.length, (_) => false.obs));
        update();
      } else {
        Get.snackbar(
          'Gagal',
          response?['message'] ?? 'Data keluarga gagal diambil.',
          backgroundColor: Colors.red.withOpacity(0.2),
          colorText: black,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      print("Gagal silahkan coba lagi $e");
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat mengambil data keluarga.',
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: black,
        snackPosition: SnackPosition.TOP,
      );
    }
  }


  Future<void> postSuketTanggungan() async {
    final token = box.read('token');
    var nikP = nikPelaporController.text;
    var keteranganP = keteranganDialogController.text;
    var selectedItems = <String>[];
    for (int i = 0; i < checkboxValues.length; i++) {
      if (checkboxValues[i].value) {
        selectedItems.add(checkboxItems[i]);
      }
    }
    if (nikP.isEmpty ||
        keteranganP.isEmpty ||
        selectedItems.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Pastikan seluruh kolom terisi dengan baik',
        backgroundColor: Colors.yellow.withOpacity(0.2),
        colorText: black,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      if (nikP.length < 16) {
        kebenaran1.value = true;
        warn1.value = "NIK kurang dari 16 digit";
      } else if (nikP.length < 16) {
        kebenaran1.value = false;
        warn1.value = "";
      } else {
        try {
          isLoading.value = true;
          final response = await apiService.postSuketTanggungan(token, nikP, selectedItems, keteranganP);
          if (response != null && response['status'] == 'sukses') {
            Get.snackbar(
              'Sukses',
              response['message'] ?? 'Permohonan Surat Keterangan Tanggungan Keluarga telah dikirimkan',
              backgroundColor: Colors.green.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            Get.snackbar(
              'Gagal',
              response?['message'] ?? 'Permohonan Surat Keterangan Tanggungan Keluarga gagal dikirimkan',
              backgroundColor: Colors.red.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan silahkan coba lagi',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: black,
            snackPosition: SnackPosition.TOP,
          );
        } finally {
          nikPelaporController.clear();
          selectedItems.clear();
          keteranganDialogController.clear();
          isLoading.value = false;
        }
        kebenaran1.value = false;
        warn1.value = "";
      }
    } 
  }

  Future<void> postSuketDomisiliPerusahaan() async {
    final token = box.read('token');
    var namaPerusahaan = namaPerusahaanController.text;
    var namaYPPerusahaan = namaCustomController.text;
    var jabatanYP = jabatanCustomController.text;
    var nikP = nikPelaporController.text;
    var namaNotaris = namaNotarisController.text;
    var noAkta = noAktaController.text;
    var tglAkta = tanggal.value;
    var namaJalan = alamatCustomController.text;
    var rt = rtCustomController.text;
    var rw = rwCustomController.text;
    var noHp = noHpCustomController.text;
    var keteranganP = keteranganDialogController.text;
    if (namaPerusahaan.isEmpty ||
        namaYPPerusahaan.isEmpty ||
        jabatanYP.isEmpty ||
        nikP.isEmpty ||
        namaNotaris.isEmpty ||
        noAkta.isEmpty ||
        tglAkta.isEmpty ||
        namaJalan.isEmpty ||
        rt.isEmpty ||
        rw.isEmpty ||
        keteranganP.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Pastikan seluruh kolom terisi dengan baik',
        backgroundColor: Colors.yellow.withOpacity(0.2),
        colorText: white,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      if (nikP.length < 16) {
        kebenaran1.value = true;
        warn1.value = "NIK kurang dari 16 digit";
      } else {
        try {
          isLoading.value = true;
          final response = await apiService.postSuketDomisiliPerusahaan(
              token,
              nikP,
              namaPerusahaan,
              namaYPPerusahaan,
              jabatanYP,
              namaNotaris,
              noAkta,
              tglAkta,
              namaJalan,
              rt,
              rw,
              noHp,
              keteranganP);
          if (response != null && response['status'] == 'sukses') {
            Get.snackbar(
              'Sukses',
              response['message'] ??
                  'Permohonan Surat Domisili Perusahaan telah dikirimkan',
              backgroundColor: Colors.green.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            Get.snackbar(
              'Gagal',
              response?['message'] ??
                  'Permohonan Surat Domisili Perusahaan gagal dikirimkan',
              backgroundColor: Colors.red.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan silahkan coba lagi',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: black,
            snackPosition: SnackPosition.TOP,
          );
        } finally {
          namaPerusahaanController.clear();
          namaCustomController.clear();
          jabatanCustomController.clear();
          nikPelaporController.clear();
          namaNotarisController.clear();
          noAktaController.clear();
          tanggal.value = '';
          alamatCustomController.clear();
          rtCustomController.clear();
          rwCustomController.clear();
          noHpCustomController.clear();
          keteranganDialogController.clear();
          isLoading.value = false;
        }
        kebenaran1.value = false;
        warn1.value = "";
      }
    }
  }

  Future<void> postSuketDomisiliUsaha() async {
    final token = box.read('token');
    var namaP = namaCustomController.text;
    var nikP = nikPelaporController.text;
    var tempatLahir = tempatLahirCustomController.text;
    var tglLahir = tanggal.value;
    var agamaP = agamaCustomController.text;
    var pekerjaanP = pekerjaanCustomController.text;
    var alamatP = alamatCustomController.text;
    var jenisUsaha = jenisUsahaController.text;
    var rt = rtCustomController.text;
    var rw = rwCustomController.text;
    var noHp = noHpCustomController.text;
    var keteranganP = keteranganDialogController.text;
    if (namaP.isEmpty ||
        nikP.isEmpty ||
        tempatLahir.isEmpty ||
        tglLahir.isEmpty ||
        agamaP.isEmpty ||
        pekerjaanP.isEmpty ||
        alamatP.isEmpty ||
        jenisUsaha.isEmpty ||
        rt.isEmpty ||
        rw.isEmpty ||
        noHp.isEmpty ||
        keteranganP.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Pastikan seluruh kolom terisi dengan baik',
        backgroundColor: Colors.yellow.withOpacity(0.2),
        colorText: white,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      if (nikP.length < 16) {
        kebenaran1.value = true;
        warn1.value = "NIK kurang dari 16 digit";
      } else {
        try {
          isLoading.value = true;
          final response = await apiService.postSuketDomisiliUsaha(
              token,
              nikP,
              namaP,
              tempatLahir,
              tglLahir,
              agamaP,
              pekerjaanP,
              alamatP,
              jenisUsaha,
              rt,
              rw,
              noHp,
              keteranganP);
          if (response != null && response['status'] == 'sukses') {
            Get.snackbar(
              'Sukses',
              response['message'] ??
                  'Permohonan Surat Domisili Usaha telah dikirimkan',
              backgroundColor: Colors.green.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            Get.snackbar(
              'Gagal',
              response?['message'] ??
                  'Permohonan Surat Domisili Usaha gagal dikirimkan',
              backgroundColor: Colors.red.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan silahkan coba lagi',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: black,
            snackPosition: SnackPosition.TOP,
          );
        } finally {
          namaCustomController.clear();
          nikPelaporController.clear();
          tempatLahirCustomController.clear();
          tanggal.value = "";
          agamaCustomController.clear();
          pekerjaanCustomController.clear();
          alamatCustomController.clear();
          jenisUsahaController.clear();
          rtCustomController.clear();
          rwCustomController.clear();
          noHpCustomController.clear();
          keteranganDialogController.clear();
          isLoading.value = false;
        }
        kebenaran1.value = false;
        warn1.value = "";
      }
    }
  }

  Future<void> postSuketPindahWilayah() async {
    final token = box.read('token');
    var nikP = nikPelaporController.text;
    var keteranganP = keteranganDialogController.text;
    var nomorSPKTP = nomorSPKTPController.text;
    var tglSPKTP = tanggal.value;

    if (nikP.isEmpty ||
        keteranganP.isEmpty ||
        tglSPKTP.isEmpty || nomorSPKTP.isEmpty) {
      Get.snackbar(
        'Perhatian',
        'Pastikan seluruh kolom terisi dengan baik',
        backgroundColor: Colors.yellow.withOpacity(0.2),
        colorText: black,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      if (nikP.length < 16) {
        kebenaran1.value = true;
        warn1.value = "NIK kurang dari 16 digit";
      } else if (nikP.length < 16) {
        kebenaran1.value = false;
        warn1.value = "";
      } else {
        try {
          isLoading.value = true;
          final response = await apiService.postSuketPindahWilayah(token, nikP, nomorSPKTP, tglSPKTP, keteranganP);
          if (response != null && response['status'] == 'sukses') {
            Get.snackbar(
              'Sukses',
              response['message'] ?? 'Permohonan Surat Keterangan Pindah Wilayah telah dikirimkan',
              backgroundColor: Colors.green.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            Get.snackbar(
              'Gagal',
              response?['message'] ?? 'Permohonan Surat Keterangan Pindah Wilayah gagal dikirimkan',
              backgroundColor: Colors.red.withOpacity(0.2),
              colorText: black,
              snackPosition: SnackPosition.TOP,
            );
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'Terjadi kesalahan silahkan coba lagi',
            backgroundColor: Colors.red.withOpacity(0.2),
            colorText: black,
            snackPosition: SnackPosition.TOP,
          );
        } finally {
          nikPelaporController.clear();
          nomorSPKTPController.clear();
          tanggal.value = '';
          keteranganDialogController.clear();
          isLoading.value = false;
        }
        kebenaran1.value = false;
        warn1.value = "";
      }
    } 
  }

  // @override
  // void onInit() {
  //   getKeluarga();
  //   super.onInit();
  // }

  @override
  void onReady() {
    fetchWeatherData();
    getKeluarga();
    super.onReady();
  }
}
