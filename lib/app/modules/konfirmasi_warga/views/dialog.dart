import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../controllers/konfirmasi_warga_controller.dart';

KonfirmasiWargaController kController = Get.put(KonfirmasiWargaController());

void showAcceptDialog(BuildContext context, int suratId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          "Konfirmasi Persetujuan",
          style: inter600(18, black),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tambahkan catatan (opsional):",
              style: inter500(14, Colors.grey[700]!),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              controller: kController.noteController,
              decoration: InputDecoration(
                hintText: "Ketik catatan...",
                hintStyle: inter500(14, abudebu),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Batal", style: montserrat500(14, gagal)),
          ),
          Obx(() => ElevatedButton(
                onPressed: kController.isLoading.value
                    ? null
                    : () {
                        kController.updateSuratAccept(suratId);
                        Future.delayed(const Duration(milliseconds: 300), () {
                          kController.getSurat();
                        });
                        Navigator.of(context).pop();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: sukses,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: kController.isLoading.value
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: white, strokeWidth: 2),
                      )
                    : Text("OK", style: montserrat500(14, white)),
              )),
        ],
      );
    },
  );
}
void showRejectDialog(BuildContext context, int suratId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          "Konfirmasi Penolakan",
          style: inter600(18, black),
        ),
        content: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Masukkan alasan penolakan:",
                  style: inter500(14, Colors.grey[700]!),
                ),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 4,
                  controller: kController.noteController,
                  decoration: InputDecoration(
                    hintText: "Tuliskan alasan...",
                    hintStyle: inter500(14, abudebu),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 8),
                kController.kebenaran.value
                    ? Text(
                        kController.warn.value,
                        style: montserrat500(12, gagal),
                      )
                    : const SizedBox.shrink(),
              ],
            )),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Batal", style: montserrat500(14, gagal)),
          ),
          ElevatedButton(
            onPressed: () {
              kController.updateSuratReject(suratId);
              Future.delayed(const Duration(milliseconds: 250), () {
                kController.getSurat();
                Get.back();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Tolak", style: montserrat500(14, white)),
          ),
        ],
      );
    },
  );
}


void showSuketKematianDialog(
    BuildContext context, Map<String, dynamic> dataSurat) {
  Map<String, dynamic> isiSurat = dataSurat['isi_surat'];
  Map<String, dynamic> dataPelapor = isiSurat['data_pelapor'];
  Map<String, dynamic> dataTerlapor = isiSurat['data_terlapor'];
  Map<String, dynamic> dataHariMeninggal = isiSurat['data_hari_meninggal'];
  Get.dialog(
    Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Surat Keterangan Kematian",
                    style: montserrat500(20, black)),
                Text("Tanggal Pengajuan : ${dataSurat['tanggal_pengajuan']}",
                    style: montserrat500(12, abupekat)),
                Text("RT. ${dataSurat['rt']} RW. ${dataSurat['rw']}",
                    style: montserrat500(12, abupekat)),
                SizedBox(height: 20.h),
                Text("Terlapor", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Nama : ${dataTerlapor['Nama']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("NIK : ${dataTerlapor['NIK']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text(
                    "Tempat, Tanggal Lahir : ${dataTerlapor['Tempat, Tanggal Lahir']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Jenis Kelamin : ${dataTerlapor['Jenis Kelamin']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Alamat : ${dataTerlapor['Alamat']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Agama : ${dataTerlapor['Agama']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Status Perkawinan : ${dataTerlapor['Status Perkawinan']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Pekerjaan : ${dataTerlapor['Pekerjaan']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Kewarganegaraan : ${dataTerlapor['Kewarganegaraan']}",
                    style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  color: abudebu,
                ),
                Text("Hari Meninggal", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Hari : ${dataHariMeninggal['Hari']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Tanggal : ${dataHariMeninggal['Tanggal']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Pukul : ${dataHariMeninggal['Pukul']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Bertempat di : ${dataHariMeninggal['Bertempat di']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Penyebab : ${dataHariMeninggal['Penyebab']}",
                    style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  color: abudebu,
                ),
                Text("Pelapor", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Nama : ${dataPelapor['Nama']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("NIK : ${dataPelapor['NIK']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text(
                    "Tempat, Tanggal Lahir : ${dataPelapor['Tempat, Tanggal Lahir']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Jenis Kelamin : ${dataPelapor['Jenis Kelamin']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Alamat : ${dataPelapor['Alamat']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text(
                    "Hubungan dengan almarhum : ${dataPelapor['Hubungan dengan almarhum']}",
                    style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 18, bottom: 6),
                  color: abudebu,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Digunakan untuk ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text: "${dataSurat['keterangan_surat']}",
                      style: montserrat700(12, black)),
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Kontak yang dapat dihubungi : ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text:
                          "${dataSurat['no_hp'] ?? 'Tidak ada kontak yang dapat dihubungi'}",
                      style: montserrat700(12, black)),
                ])),
              ],
            )),
      ),
    ),
    barrierDismissible: true,
  );
}

void showSuketPenghasilanDialog(
    BuildContext context, Map<String, dynamic> dataSurat) {
  Map<String, dynamic> isiSurat = dataSurat['isi_surat'];
  Map<String, dynamic> dataPelapor = isiSurat['data_pelapor'];
  String penghasilanP = isiSurat['penghasilanP'];
  Get.dialog(
    Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Surat Keterangan Penghasilan",
                  style: montserrat500(20, black)),
              Text("Tanggal Pengajuan : ${dataSurat['tanggal_pengajuan']}",
                  style: montserrat500(12, abupekat)),
              Text("RT. ${dataSurat['rt']} RW. ${dataSurat['rw']}",
                  style: montserrat500(12, abupekat)),
              SizedBox(height: 20.h),
              Text("Pelapor", style: montserrat700(16, black)),
              SizedBox(height: 3.h),
              Text("Nama : ${dataPelapor['Nama']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text("NIK : ${dataPelapor['NIK']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text(
                  "Tempat, Tanggal Lahir : ${dataPelapor['Tempat, Tanggal Lahir']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text("Jenis Kelamin : ${dataPelapor['Jenis Kelamin']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text("Agama : ${dataPelapor['Agama']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text("Pekerjaan : ${dataPelapor['Pekerjaan']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text("Alamat : ${dataPelapor['Alamat']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text("Penghasilan : Rp.$penghasilanP",
                  style: montserrat500(12, black)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1.h,
                margin: const EdgeInsets.only(top: 18, bottom: 6),
                color: abudebu,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Digunakan untuk ",
                    style: montserrat500(12, black)),
                TextSpan(
                    text: "${dataSurat['keterangan_surat']}",
                    style: montserrat700(12, black)),
              ])),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Kontak yang dapat dihubungi : ",
                    style: montserrat500(12, black)),
                TextSpan(
                    text:
                        "${dataSurat['no_hp'] ?? 'Tidak ada kontak yang dapat dihubungi'}",
                    style: montserrat700(12, black)),
              ])),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: true,
  );
}

void showSuketTidakMampuDialog(
    BuildContext context, Map<String, dynamic> dataSurat) {
  Map<String, dynamic> isiSurat = dataSurat['isi_surat'];
  Map<String, dynamic> dataPelapor = isiSurat['data_pelapor'];
  Get.dialog(
    Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Surat Keterangan Tidak Mampu",
                  style: montserrat500(20, black)),
              Text("Tanggal Pengajuan : ${dataSurat['tanggal_pengajuan']}",
                  style: montserrat500(12, abupekat)),
              Text("RT. ${dataSurat['rt']} RW. ${dataSurat['rw']}",
                  style: montserrat500(12, abupekat)),
              SizedBox(height: 20.h),
              Text("Pelapor", style: montserrat700(16, black)),
              SizedBox(height: 3.h),
              Text("Nama : ${dataPelapor['Nama']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text("NIK : ${dataPelapor['NIK']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text(
                  "Tempat, Tanggal Lahir : ${dataPelapor['Tempat, Tanggal Lahir']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text("Jenis Kelamin : ${dataPelapor['Jenis Kelamin']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text("Agama : ${dataPelapor['Agama']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text("Pekerjaan : ${dataPelapor['Pekerjaan']}",
                  style: montserrat500(12, black)),
              SizedBox(height: 3.h),
              Text("Alamat : ${dataPelapor['Alamat']}",
                  style: montserrat500(12, black)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1.h,
                margin: const EdgeInsets.only(top: 18, bottom: 6),
                color: abudebu,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Digunakan untuk ",
                    style: montserrat500(12, black)),
                TextSpan(
                    text: "${dataSurat['keterangan_surat']}",
                    style: montserrat700(12, black)),
              ])),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Kontak yang dapat dihubungi : ",
                    style: montserrat500(12, black)),
                TextSpan(
                    text:
                        "${dataSurat['no_hp'] ?? 'Tidak ada kontak yang dapat dihubungi'}",
                    style: montserrat700(12, black)),
              ])),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: true,
  );
}

void showSuketGaibDialog(BuildContext context, Map<String, dynamic> dataSurat) {
  Map<String, dynamic> isiSurat = dataSurat['isi_surat'];
  Map<String, dynamic> dataPelapor = isiSurat['data_pelapor'];
  Map<String, dynamic> dataTerlapor = isiSurat['data_terlapor'];
  String bulanHilang = isiSurat['bulanHilang'];
  String tahunHilang = isiSurat['tahunHilang'];
  Get.dialog(
    Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Surat Keterangan Gaib",
                    style: montserrat500(20, black)),
                Text("Tanggal Pengajuan : ${dataSurat['tanggal_pengajuan']}",
                    style: montserrat500(12, abupekat)),
                Text("RT. ${dataSurat['rt']} RW. ${dataSurat['rw']}",
                    style: montserrat500(12, abupekat)),
                SizedBox(height: 20.h),
                Text("Terlapor", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Nama : ${dataTerlapor['Nama']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("NIK : ${dataTerlapor['NIK']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text(
                    "Tempat, Tanggal Lahir : ${dataTerlapor['Tempat, Tanggal Lahir']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Warga Negara : ${dataTerlapor['Warga Negara']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Agama : ${dataTerlapor['Agama']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Pekerjaan : ${dataTerlapor['Pekerjaan']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Bulan Hilang : $bulanHilang",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Tahun Hilang : $tahunHilang",
                    style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  color: abudebu,
                ),
                Text("Pelapor", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Nama : ${dataPelapor['Nama']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("NIK : ${dataPelapor['NIK']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text(
                    "Tempat, Tanggal Lahir : ${dataPelapor['Tempat, Tanggal Lahir']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Warga Negara : ${dataPelapor['Warga Negara']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Agama : ${dataPelapor['Agama']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Pekerjaan : ${dataPelapor['Pekerjaan']}",
                    style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Alamat : ${dataPelapor['Alamat']}",
                    style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 18, bottom: 6),
                  color: abudebu,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Digunakan untuk ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text: "${dataSurat['keterangan_surat']}",
                      style: montserrat700(12, black)),
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Kontak yang dapat dihubungi : ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text:
                          "${dataSurat['no_hp'] ?? 'Tidak ada kontak yang dapat dihubungi'}",
                      style: montserrat700(12, black)),
                ])),
              ],
            )),
      ),
    ),
    barrierDismissible: true,
  );
}

void showSuketOrangYangSamaDialog(BuildContext context, Map<String, dynamic> dataSurat) {
  Map<String, dynamic> isiSurat = dataSurat['isi_surat'];
  Map<String, dynamic> dataPelapor = isiSurat['data_pelapor'];
  String dokumenBenar = isiSurat['dokumenBenar'];
  String dokumenSalah = isiSurat['dokumenSalah'];
  String nomorDokumenBenar = isiSurat['nomorDokumenBenar'];
  String nomorDokumenSalah= isiSurat['nomorDokumenSalah'];
  String dataBenar = isiSurat['dataBenar'];
  String dataSalah= isiSurat['dataSalah'];

  // "dokumenBenar" : dokumenBenar,
  // "dokumenSalah" : dokumenSalah,
  // "nomorDokumenBenar" : nomorDokumenBenar,
  // "nomorDokumenSalah" : nomorDokumenSalah,
  // "dataBenar" : dataBenar,
  // "dataSalah" : dataSalah,
  Get.dialog(
    Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Surat Keterangan Pindah Wilayah", style: montserrat500(20, black)),
                Text("Tanggal Pengajuan : ${dataSurat['tanggal_pengajuan']}", style: montserrat500(12, abupekat)),
                Text("RT. ${dataSurat['rt']} RW. ${dataSurat['rw']}", style: montserrat500(12, abupekat)),
                SizedBox(height: 20.h),
                Text("Pelapor", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Nama : ${dataPelapor['Nama']}", style: montserrat500(12, black)),
                Text("NIK : ${dataPelapor['NIK']}", style: montserrat500(12, black)),
                Text("Tempat, Tanggal Lahir : ${dataPelapor['Tempat, Tanggal Lahir']}", style: montserrat500(12, black)),
                Text("Kewarganegaraan : ${dataPelapor['Kewarganegaraan']}", style: montserrat500(12, black)),
                Text("Agama : ${dataPelapor['Agama']}", style: montserrat500(12, black)),
                Text("Pekerjaan : ${dataPelapor['Pekerjaan']}", style: montserrat500(12, black)),
                Text("Alamat : ${dataPelapor['Alamat']}", style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  color: abudebu,
                ),
                Text("Data Benar", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Dokumen : $dokumenBenar", style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Nomor Dokumen : $nomorDokumenBenar", style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Data yang Benar : $dataBenar", style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  color: abudebu,
                ),
                Text("Data Salah", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Dokumen : $dokumenSalah", style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Nomor Dokumen : $nomorDokumenSalah", style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Data yang Salah : $dataSalah", style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 18, bottom: 6),
                  color: abudebu,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Digunakan untuk ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text: "${dataSurat['keterangan_surat']}",
                      style: montserrat700(12, black)),
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Kontak yang dapat dihubungi : ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text:"${dataSurat['no_hp'] ?? 'Tidak ada kontak yang dapat dihubungi'}",
                      style: montserrat700(12, black)),
                ])),
              ],
            )),
      ),
    ),
    barrierDismissible: true,
  );
}

void showSuketDomisiliDialog(BuildContext context, Map<String, dynamic> dataSurat) {
  Map<String, dynamic> isiSurat = dataSurat['isi_surat'];
  Map<String, dynamic> dataPelapor = isiSurat['data_pelapor'];
  Get.dialog(
    Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Surat Keterangan Domisili",
                    style: montserrat500(20, black)),
                Text("Tanggal Pengajuan : ${dataSurat['tanggal_pengajuan']}",
                    style: montserrat500(12, abupekat)),
                Text("RT. ${dataSurat['rt']} RW. ${dataSurat['rw']}",
                    style: montserrat500(12, abupekat)),
                SizedBox(height: 20.h),
                Text("Pelapor", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Nama : ${dataPelapor['Nama']}",
                    style: montserrat500(12, black)),
                Text("NIK : ${dataPelapor['NIK']}",
                    style: montserrat500(12, black)),
                Text(
                    "Tempat, Tanggal Lahir : ${dataPelapor['Tempat, Tanggal Lahir']}",
                    style: montserrat500(12, black)),
                Text("Kewarganegaraan : ${dataPelapor['Kewarganegaraan']}",
                    style: montserrat500(12, black)),
                Text("Agama : ${dataPelapor['Agama']}",
                    style: montserrat500(12, black)),
                Text("Pekerjaan : ${dataPelapor['Pekerjaan']}",
                    style: montserrat500(12, black)),
                Text("Alamat : ${dataPelapor['Alamat']}",
                    style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 18, bottom: 6),
                  color: abudebu,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Digunakan untuk ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text: "${dataSurat['keterangan_surat']}",
                      style: montserrat700(12, black)),
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Kontak yang dapat dihubungi : ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text:
                          "${dataSurat['no_hp'] ?? 'Tidak ada kontak yang dapat dihubungi'}",
                      style: montserrat700(12, black)),
                ])),
              ],
            )),
      ),
    ),
    barrierDismissible: true,
  );
}

void showSuketDomisiliPerusahaanDialog(
    BuildContext context, Map<String, dynamic> dataSurat) {
  Map<String, dynamic> isiSurat = dataSurat['isi_surat'];
  Map<String, dynamic> domisiliPerusahaan = isiSurat['domisili_perusahaan'];
  Map<String, dynamic> dataPerusahaan = isiSurat['data_perusahaan'];
  Get.dialog(
    Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Surat Keterangan Domisili Perusahaan",
                    style: montserrat500(20, black)),
                Text("Tanggal Pengajuan : ${dataSurat['tanggal_pengajuan']}",
                    style: montserrat500(12, abupekat)),
                Text("RT. ${dataSurat['rt']} RW. ${dataSurat['rw']}",
                    style: montserrat500(12, abupekat)),
                SizedBox(height: 20.h),
                Text("Data Perusahaan", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Nama Perusahaan: ${dataPerusahaan['Nama Perusahaan']}",
                    style: montserrat500(12, black)),
                Text("Nama : ${dataPerusahaan['Nama']}",
                    style: montserrat500(12, black)),
                Text("Jabatan : ${dataPerusahaan['Jabatan']}",
                    style: montserrat500(12, black)),
                Text("NIK : ${dataPerusahaan['NIK']}",
                    style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 18, bottom: 6),
                  color: abudebu,
                ),
                Text("Domisili Perusahaan",
                    style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Jalan : ${domisiliPerusahaan['Jalan']}",
                    style: montserrat500(12, black)),
                Text("Kelurahan : ${domisiliPerusahaan['Kelurahan']}",
                    style: montserrat500(12, black)),
                Text("Kecamatan : ${domisiliPerusahaan['Kecamatan']}",
                    style: montserrat500(12, black)),
                Text("Kota : ${domisiliPerusahaan['Kota']}",
                    style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 18, bottom: 6),
                  color: abudebu,
                ),
                Text("Akta Perusahaan", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Nomor Akta : ${isiSurat['noAkta']}",
                    style: montserrat500(12, black)),
                Text("Tanggal Akta : ${isiSurat['tanggalAkta']}",
                    style: montserrat500(12, black)),
                Text("Nama Notaris : ${isiSurat['namaNotaris']}",
                    style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 18, bottom: 6),
                  color: abudebu,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Digunakan untuk ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text: "${dataSurat['keterangan_surat']}",
                      style: montserrat700(12, black)),
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Kontak yang dapat dihubungi : ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text:
                          "${dataSurat['no_hp'] ?? 'Tidak ada kontak yang dapat dihubungi'}",
                      style: montserrat700(12, black)),
                ])),
              ],
            )),
      ),
    ),
    barrierDismissible: true,
  );
}

void showSuketDomisiliUsahaDialog(
    BuildContext context, Map<String, dynamic> dataSurat) {
  Map<String, dynamic> isiSurat = dataSurat['isi_surat'];
  Map<String, dynamic> dataPengajuan = isiSurat['data_pengajuan'];
  Map<String, dynamic> alamatPengajuan = isiSurat['alamat_pengajuan'];
  String jenisUsaha = isiSurat['jenisUsaha'];
  Get.dialog(
    Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Surat Keterangan Domisili Usaha",
                    style: montserrat500(20, black)),
                Text("Tanggal Pengajuan : ${dataSurat['tanggal_pengajuan']}",
                    style: montserrat500(12, abupekat)),
                Text("RT. ${dataSurat['rt']} RW. ${dataSurat['rw']}",
                    style: montserrat500(12, abupekat)),
                SizedBox(height: 20.h),
                Text("Pelapor", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Nama : ${dataPengajuan['Nama']}",
                    style: montserrat500(12, black)),
                Text("NIK : ${dataPengajuan['NIK']}",
                    style: montserrat500(12, black)),
                Text(
                    "Tempat, Tanggal Lahir : ${dataPengajuan['Tempat, Tanggal Lahir']}",
                    style: montserrat500(12, black)),
                Text("Agama : ${dataPengajuan['Agama']}",
                    style: montserrat500(12, black)),
                Text("Pekerjaan : ${dataPengajuan['Pekerjaan']}",
                    style: montserrat500(12, black)),
                Text("Alamat : ${dataPengajuan['Alamat']}",
                    style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 18, bottom: 6),
                  color: abudebu,
                ),
                Text("Detail Usaha", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Jenis Usaha : $jenisUsaha",
                    style: montserrat500(12, black)),
                Text("Alamat : ${alamatPengajuan['Alamat']}",
                    style: montserrat500(12, black)),
                Text("Kelurahan : ${alamatPengajuan['Kelurahan']}",
                    style: montserrat500(12, black)),
                Text("Kecamatan : ${alamatPengajuan['Kecamatan']}",
                    style: montserrat500(12, black)),
                Text("Kota : ${alamatPengajuan['Kota']}",
                    style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 18, bottom: 6),
                  color: abudebu,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Digunakan untuk ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text: "${dataSurat['keterangan_surat']}",
                      style: montserrat700(12, black)),
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Kontak yang dapat dihubungi : ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text:
                          "${dataSurat['no_hp'] ?? 'Tidak ada kontak yang dapat dihubungi'}",
                      style: montserrat700(12, black)),
                ])),
              ],
            )),
      ),
    ),
    barrierDismissible: true,
  );
}
void showSuketTanggunganDialog(BuildContext context, Map<String, dynamic> dataSurat) {
  Map<String, dynamic> isiSurat = dataSurat['isi_surat'] ?? {};
  Map<String, dynamic> dataPelapor = isiSurat['data_pelapor'] ?? {};
  List<Map<String, dynamic>> tanggunganData = List<Map<String, dynamic>>.from(isiSurat['tanggungan_data'] ?? []);

  Get.dialog(
    Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Surat Keterangan Pindah Wilayah", style: montserrat500(20, black)),
              SizedBox(height: 8.h),
              Text("Tanggal Pengajuan : ${dataSurat['tanggal_pengajuan'] ?? 'Tidak tersedia'}", style: montserrat500(12, abupekat)),
              Text("RT. ${dataSurat['rt'] ?? '-'} RW. ${dataSurat['rw'] ?? '-'}", style: montserrat500(12, abupekat)),
              SizedBox(height: 20.h),

              // Data Pelapor
              Text("Pelapor", style: montserrat700(16, black)),
              SizedBox(height: 3.h),
              Text("Nama : ${dataPelapor['Nama'] ?? 'Tidak tersedia'}", style: montserrat500(12, black)),
              Text("NIK : ${dataPelapor['NIK'] ?? 'Tidak tersedia'}", style: montserrat500(12, black)),
              Text("Tempat, Tanggal Lahir : ${dataPelapor['Tempat, Tanggal Lahir'] ?? 'Tidak tersedia'}", style: montserrat500(12, black)),
              Text("Kewarganegaraan : ${dataPelapor['Kewarganegaraan'] ?? 'Tidak tersedia'}", style: montserrat500(12, black)),
              Text("Agama : ${dataPelapor['Agama'] ?? 'Tidak tersedia'}", style: montserrat500(12, black)),
              Text("Pekerjaan : ${dataPelapor['Pekerjaan'] ?? 'Tidak tersedia'}", style: montserrat500(12, black)),
              Text("Alamat : ${dataPelapor['Alamat'] ?? 'Tidak tersedia'}", style: montserrat500(12, black)),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 1.h,
                margin: const EdgeInsets.symmetric(vertical: 12),
                color: abudebu,
              ),

              // Data Tanggungan
              Text("Tanggungan Pelapor", style: montserrat700(16, black)),
              SizedBox(height: 6.h),
              ...tanggunganData.asMap().entries.map((entry) {
                int index = entry.key + 1;
                Map<String, dynamic> tanggungan = entry.value;
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text("Tanggungan $index : ${tanggungan['Nama'] ?? 'Tidak tersedia'}", style: montserrat500(12, black)),
                );
              }).toList(),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 1.h,
                margin: const EdgeInsets.symmetric(vertical: 12),
                color: abudebu,
              ),

              // Keterangan dan Kontak
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Digunakan untuk ", style: montserrat500(12, black)),
                    TextSpan(text: "${dataSurat['keterangan_surat'] ?? 'Tidak tersedia'}", style: montserrat700(12, black)),
                  ],
                ),
              ),
              SizedBox(height: 6.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Kontak yang dapat dihubungi : ", style: montserrat500(12, black)),
                    TextSpan(text: "${dataSurat['no_hp'] ?? 'Tidak ada kontak yang dapat dihubungi'}", style: montserrat700(12, black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: true,
  );
}


void showSuketPindahWilayahDialog(BuildContext context, Map<String, dynamic> dataSurat) {
  Map<String, dynamic> isiSurat = dataSurat['isi_surat'];
  Map<String, dynamic> dataPelapor = isiSurat['data_pelapor'];
  String nomorSPKTP = isiSurat['nomorSPKTP'];
  String tglSPKTP = isiSurat['tglSPKTP'];
  Get.dialog(
    Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Surat Keterangan Pindah Wilayah", style: montserrat500(20, black)),
                Text("Tanggal Pengajuan : ${dataSurat['tanggal_pengajuan']}", style: montserrat500(12, abupekat)),
                Text("RT. ${dataSurat['rt']} RW. ${dataSurat['rw']}", style: montserrat500(12, abupekat)),
                SizedBox(height: 20.h),
                Text("Pelapor", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Nama : ${dataPelapor['Nama']}", style: montserrat500(12, black)),
                Text("NIK : ${dataPelapor['NIK']}", style: montserrat500(12, black)),
                Text("Tempat, Tanggal Lahir : ${dataPelapor['Tempat, Tanggal Lahir']}", style: montserrat500(12, black)),
                Text("Kewarganegaraan : ${dataPelapor['Kewarganegaraan']}", style: montserrat500(12, black)),
                Text("Agama : ${dataPelapor['Agama']}", style: montserrat500(12, black)),
                Text("Pekerjaan : ${dataPelapor['Pekerjaan']}", style: montserrat500(12, black)),
                Text("Alamat : ${dataPelapor['Alamat']}", style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  color: abudebu,
                ),
                Text("Surat Pernyataan Kepemilikan/Penguasaan Tanah", style: montserrat700(16, black)),
                SizedBox(height: 3.h),
                Text("Nomor : $nomorSPKTP", style: montserrat500(12, black)),
                SizedBox(height: 3.h),
                Text("Tanggal SPKTP: $tglSPKTP", style: montserrat500(12, black)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.h,
                  margin: const EdgeInsets.only(top: 18, bottom: 6),
                  color: abudebu,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Digunakan untuk ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text: "${dataSurat['keterangan_surat']}",
                      style: montserrat700(12, black)),
                ])),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Kontak yang dapat dihubungi : ",
                      style: montserrat500(12, black)),
                  TextSpan(
                      text:"${dataSurat['no_hp'] ?? 'Tidak ada kontak yang dapat dihubungi'}",
                      style: montserrat700(12, black)),
                ])),
              ],
            )),
      ),
    ),
    barrierDismissible: true,
  );
}
