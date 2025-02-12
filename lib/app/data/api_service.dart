// import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'api_client.dart';

// import 'package:path/path.dart' as path;

class ApiService extends GetConnect {
  final ApiClient _apiClient = Get.put(ApiClient());

  Future<Map<String, dynamic>?> login(String noKK, String password) async {
    final formData = FormData({'noKK': noKK,'password': password,});
    final response = await _apiClient.post('/login', formData);
    if (response.status.hasError) {
      return null;
    } else {
      return response.body;
    }
  }

  Future<Map<String, dynamic>?> logout(String token) async {
    final formData = FormData({});
    final response = await _apiClient.post(
      '/logout',
      formData,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.status.hasError) {
      return null;
    } else {
      return response.body;
    }
  }

  Future<Map<String, dynamic>?> register(String email, String noKK, String password) async {
    final formData = FormData({'email': email, 'noKK': noKK, 'password': password});
    final response = await _apiClient.post('/post_users', formData);
    if (response.status.hasError) {
      return null;
    } else {
      return response.body;
    }
  }
  
  Future<Map<String, dynamic>?> forgotPassword(String email) async {
    final formData = FormData({'email': email});
    final response = await _apiClient.post('/forgot-password', formData);
    return response.body;
  }
  // GET
  Future<Map<String, dynamic>?> getUser(String token) async {
    final response = await _apiClient.get('/get_user_personal', headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> getWilayah(String token) async {
    final response = await _apiClient.get('/get_wilayah', headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> getKeluarga(String token) async {
    final response = await _apiClient.get('/get_keluarga', headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> getRekom(String token) async {
    final response = await _apiClient.get('/get_rekom', headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> getRekomPersonal(String token) async {
    final response = await _apiClient.get('/get_rekom_personal', headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> getSurat(String token) async {
    final response = await _apiClient.get('/get_surat', headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> getRtRw(String token) async {
    final response = await _apiClient.get('/get_rt_rw', headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> getRiwayat(String token) async {
    final response = await _apiClient.get('/get_riwayat', headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  // END GET

  // POST
  Future<Map<String, dynamic>?> postKeluarga(String token, String nama, String nik,String tempatLahir, String peran, String jenisKelamin, String pendidikan, String golDarah,String pekerjaan, String agama, String ttl, String statusPerkawinan) async {
    final formData = FormData({'nama': nama, 'nik': nik, 'peran': peran, 'tempat_lahir':tempatLahir, 'jenis_kelamin': jenisKelamin, 'agama': agama, 'ttl': ttl, 'pendidikan': pendidikan, 'gol_darah': golDarah, 'pekerjaan': pekerjaan, 'status_perkawinan' : statusPerkawinan});
    final response = await _apiClient.post('/post_keluarga',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> postRekom(String token, int uId, String rt, String rw) async {
    final formData = FormData({'uId': uId, 'rt': rt, 'rw': rw});
    final response = await _apiClient.post('/post_rekom',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> postSuketKematian(String token, String nikT, String kewarganegaraanT, String hariHM, String tanggalHM, String pukulHM, String bertempatHM, String penyebabHM, String nikP, String hubunganP, String keteranganP) async {
    final formData = FormData({'nikT': nikT, 'nikP': nikP, 'kewarganegaraanT': kewarganegaraanT, 'hubunganP': hubunganP,'keteranganP': keteranganP,'hariHM': hariHM,'tanggalHM': tanggalHM,'pukulHM': pukulHM,'bertempatHM': bertempatHM, "penyebabHM" : penyebabHM });
    final response = await _apiClient.post('/post_suket_kematian',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> postSuketPenghasilan(String token, String nikP, String penghasilanP, String keteranganP) async {
    final formData = FormData({'nikP': nikP, 'penghasilanP': penghasilanP, 'keteranganP': keteranganP});
    final response = await _apiClient.post('/post_suket_penghasilan',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> postSuketTidakMampu(String token, String nikP, String keteranganP) async {
    final formData = FormData({'nikP': nikP, 'keteranganP': keteranganP});
    final response = await _apiClient.post('/post_suket_tidak_mampu',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> postSuketGaib(String token, String nikP, String nikT, String wargaNegaraP, String wargaNegaraT, String hubunganP, String keteranganP, String bulanHilang, String tahunHilang) async {
    final formData = FormData({'nikP': nikP, 'nikT': nikT, 'wargaNegaraP': wargaNegaraP, 'wargaNegaraT': wargaNegaraT, 'hubunganP' : hubunganP, 'keteranganP': keteranganP, 'bulanHilang' : bulanHilang, "tahunHilang" : tahunHilang});
    final response = await _apiClient.post('/post_suket_gaib',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> postSuketOrangYangSama(String token, String nikP, String dokumenBenar, String dokumenSalah,String nomorDokumenBenar,String nomorDokumenSalah, String dataBenar, String dataSalah,String keteranganP) async {
    final formData = FormData({'nikP': nikP, 'dokumenBenar': dokumenBenar, 'dokumenSalah': dokumenSalah,'nomorDokumenBenar': nomorDokumenBenar,'nomorDokumenSalah': nomorDokumenSalah, 'dataBenar': dataBenar, 'dataSalah': dataSalah, 'keteranganP': keteranganP});
    final response = await _apiClient.post('/post_suket_orang_yang_sama',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  // Future<Map<String, dynamic>?> postSuketDomisili(String token, String nikP, String kewarganegaraanP, String keteranganP) async {
  //   final formData = FormData({'nikP': nikP, 'kewarganegaraanP': kewarganegaraanP, 'keteranganP': keteranganP});
  //   final response = await _apiClient.post('/post_suket_domisili',formData, headers: {'Authorization': 'Bearer $token'});
  //   return response.body;
  // }
  Future<Map<String, dynamic>?> postSuketDomisiliPerusahaan(String token, String nikYP, String namaPerusahaan, String namaYPPerusahaan, String jabatanYP, String namaNotaris, String noAkta, String tanggalAkta, String namaJalan, String rt, String rw, String noHp, String keteranganP) async {
    final formData = FormData({'nikYP': nikYP, 'namaPerusahaan': namaPerusahaan, 'namaYPPerusahaan': namaYPPerusahaan, 'jabatanYP' : jabatanYP, 'namaNotaris' : namaNotaris, "noAkta" : noAkta, "tanggalAkta" : tanggalAkta, "namaJalan" : namaJalan, "rt" : rt, "rw" : rw, "noHp" : noHp,"keteranganP" : keteranganP});
    final response = await _apiClient.post('/post_suket_domisili_perusahaan',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> postSuketDomisiliUsaha(String token, String nikP, String namaP, String tempatLahir, String ttlP, String agamaP, String pekerjaanP, String alamatP, String jenisUsaha, String rt, String rw, String noHp, String keteranganP) async {
    final formData = FormData({'nikP': nikP, 'namaP': namaP, 'tempatLahir': tempatLahir, 'ttlP' : ttlP, 'agamaP' : agamaP, "pekerjaanP" : pekerjaanP, "alamatP" : alamatP, "jenisUsaha" : jenisUsaha, "rt" : rt, "rw" : rw, "noHp" : noHp,"keteranganP" : keteranganP});
    final response = await _apiClient.post('/post_suket_domisili_usaha',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> postSuketTanggungan(String token, String nikP, List<String> tanggungan, String keteranganP) async {
    final formData = FormData({'nikP': nikP, 'tanggungan': jsonEncode(tanggungan), "keteranganP" : keteranganP});
    final response = await _apiClient.post('/post_suket_tanggungan',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> postSuketPindahWilayah(String token, String nikP, String nomorSPKTP, String tglSPKTP, String keteranganP) async {
    final formData = FormData({'nikP': nikP, 'nomorSPKTP': nomorSPKTP, 'tglSPKTP': tglSPKTP, "keteranganP" : keteranganP});
    final response = await _apiClient.post('/post_suket_pindah_wilayah',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  // END POST
  
  // UPDATE
  Future<Map<String, dynamic>?> updateProfil(String noKK,String email,String? pathFile,String alamat,String noHp, String token) async {
    var formData = FormData({'noKK' : noKK,'email' : email,'alamat' : alamat,'noHp' : noHp});
    if(pathFile != null && pathFile.isNotEmpty){
      final file = MultipartFile(File(pathFile), filename: pathFile.split("/").last);
      formData.files.add(MapEntry('poto_profil', file));
    }
    final response = await _apiClient.post("/update_user", formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> updateGambarKK(String pathFile, String token) async {
    final file = MultipartFile(File(pathFile), filename: pathFile.split("/").last);
    final formData = FormData({'kk_gambar': file});
    final response = await _apiClient.post('/update_user_kk',formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> updateKeluarga(int wargaId, String nama,String nik, String tempatLahir, String peran,String jenisKelamin,String agama, String statusPerkawinan, String ttl,String pendidikan,String golDarah,String pekerjaan, String token) async {
    var formData = FormData({'nama' : nama,'nik' : nik, 'tempat_lahir':tempatLahir, 'peran' : peran,'jenis_kelamin' : jenisKelamin, 'agama' : agama, 'status_perkawinan': statusPerkawinan, 'ttl' : ttl,'pendidikan' : pendidikan,'gol_darah' : golDarah,'pekerjaan' : pekerjaan});    
    final response = await _apiClient.post("/update_keluarga/$wargaId", formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> updateRekom(int rekomId, String status, String token) async {
    var formData = FormData({"status" : status, "rekomId" : rekomId});    
    final response = await _apiClient.post("/update_rekom", formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> updatePassword(String password, String token) async {
    var formData = FormData({"password" : password});    
    final response = await _apiClient.post("/update_password", formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> updateSuratAccept(String token, int suratId, String catatan) async {
    var formData = FormData({"suratId" : suratId, "catatan" : catatan});    
    final response = await _apiClient.post("/update_surat_accept", formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  Future<Map<String, dynamic>?> updateSuratReject(String token, int suratId, String catatan) async {
    var formData = FormData({"suratId" : suratId, "catatan" : catatan});    
    final response = await _apiClient.post("/update_surat_reject", formData, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
  // END UPDATE

  // DELETE
  Future<Map<String, dynamic>?>deleteKeluarga(int wargaId, String token) async {
    final response = await _apiClient.post('/del_keluarga/$wargaId', {}, headers: {'Authorization': 'Bearer $token'},);
    return response.body;
  }
  Future<Map<String, dynamic>?>deleteRekom(int rekomId, String token) async {
    var formData = FormData({"rekomId" : rekomId});    
    final response = await _apiClient.post('/del_rekom', formData, headers: {'Authorization': 'Bearer $token'},);
    return response.body;
  }
  // END DELETE
  
}
