import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../../../template/kolom_inputan.dart';
import '../controllers/beranda_controller.dart';


void showLogoutDialog(BuildContext context, BerandaController bController) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:
            Text("Konfirmasi Keluar", style: montserrat600(12, black)),
        content: Text("Apakah Anda yakin ingin keluar?",
            style: montserrat600(16, gagal)),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(gagal.withOpacity(0.6))),
            child: Text("Tidak", style: inter500(12, white)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              bController.logout();
            },
            style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(sukses.withOpacity(0.6))),
            child: Text("Ya", style: inter500(12, white)),
          ),
        ],
      );
    },
  );
}

void showSuketKematianDialog(BuildContext context, BerandaController bController) {
  Get.bottomSheet(
    backgroundColor: white,
    SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: 50.w,
              height: 3.h,
              color: abudebu,
              margin: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 4),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text("Data Terlapor", style: montserrat600(16, black)),
                    SizedBox(height: 8.h),
                    // Input for NIK Terlapor
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.nikTerlaporController,
                      label: "NIK Terlapor",
                      labelStyle: inter400(14, abupekat),
                      hint: "cth : 14711xxxxxxxxxxx",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 4.h),
                    bController.kebenaran1.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn1.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    // Input for Kewarganegaraan Terlapor
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.kewarganegaraanTerlaporController,
                      label: "Kewarganegaraan Terlapor",
                      labelStyle: inter400(14, abupekat),
                      hint: "cth : WNI/WNA",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 20.h),
                    Text("Data Hari Meninggal", style: montserrat600(16, black)),
                    SizedBox(height: 4.h),
                    // Input for Hari Meninggal
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.hariMeninggalController,
                      label: "Hari Meninggal",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Senin",
                      hintStyle: inter400(14, abupekat),
                    ),
                    const SizedBox(height: 8),
                    // Input for Tanggal Meninggal
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 16.w, left: 16.w),
                            height: 56.h,
                            child: Text("Tanggal Meninggal : ",
                                style: inter500(14, abupekat))),
                        Obx(() => Text(
                            bController.tanggal.value.isEmpty
                                ? "00/00/0000"
                                : bController.tanggal.value,
                            style: inter500(14, black))),
                        InkWell(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              bController.setTanggal(pickedDate);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                                color: primary3,
                                borderRadius: BorderRadius.circular(4.r)),
                            child: Icon(Icons.date_range_outlined,
                                color: black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Input for Pukul Meninggal
                    GestureDetector(
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          final formattedTime = pickedTime.format(context);
                          bController.pukulMeninggalController.text =
                              formattedTime;
                        }
                      },
                      child: AbsorbPointer(
                        child: KolomInputan(
                          isNumber: false,
                          isPassword: false,
                          textEditingC: bController.pukulMeninggalController,
                          label: "Pukul Meninggal (Waktu Setempat)",
                          labelStyle: inter500(14, abupekat),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.tempatMeninggalController,
                      label: "Bertempat di",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Rumah",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    // Input for Penyebab Kematian
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.penyebabMeninggalController,
                      label: "Penyebab Kematian",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Sakit",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 20.h),
                    Text("Data Pelapor", style: inter600(16, black)),
                    SizedBox(height: 8.h),
                    // Input for NIK Pelapor
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.nikPelaporController,
                      label: "NIK Pelapor",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 14711***********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    bController.kebenaran2.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn2.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.hubunganPelaporController,
                      label: "Hubungan dengan Terlapor",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Anak",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 4.h),
                    // Input for Hubungan dengan Terlapor
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      maxLines: 4,
                      textEditingC: bController.keteranganDialogController,
                      label: "Keperluan Surat",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Ganti KK",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 20.h),
                    // Submit Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketKematian();
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(sukses)),
                        child: bController.isLoading.value
                            ? CircularProgressIndicator(color: white)
                            : Text("Simpan", style: inter500(14, white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showSuketPenghasilanDialog(BuildContext context, BerandaController bController) {
  Get.bottomSheet(
    backgroundColor: Colors.white,
    SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: 50.w,
              height: 3.h,
              color: abudebu,
              margin: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NIK Input
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.nikPelaporController,
                      label: "NIK",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 14711***********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 4.h),
                    bController.kebenaran1.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn1.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    // Penghasilan Input
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.penghasilanController,
                      label: "Penghasilan",
                      labelStyle: inter500(14, abupekat),
                      prefixText: "Rp. ",
                      hint: "cth : 5.000.000 (jangan gunakan simbol titik atau koma)",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      maxLines: 4,
                      textEditingC: bController.keteranganDialogController,
                      label: "Keperluan Surat",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : administrasi pendukung beasiswa anak",
                      hintStyle: inter400(14, abupekat),
                    ),
                    const SizedBox(height: 24.0),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketPenghasilan();
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(sukses)),
                        child: bController.isLoading.value
                            ? CircularProgressIndicator(color: white)
                            : Text("Simpan", style: inter500(14, white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showSuketTidakMampuDialog(BuildContext context, BerandaController bController) {
  Get.bottomSheet(
    backgroundColor: Colors.white,
    SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: 50.w,
              height: 3.h,
              color: abudebu,
              margin: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NIK Input
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.nikPelaporController,
                      label: "NIK",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 14711***********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 4.h),
                    bController.kebenaran1.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn1.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      maxLines: 4,
                      textEditingC: bController.keteranganDialogController,
                      label: "Keperluan Surat",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : administrasi pendukung beasiswa anak",
                      hintStyle: inter400(14, abupekat),
                    ),
                    const SizedBox(height: 24.0),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketTidakMampu();
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(sukses)),
                        child: bController.isLoading.value
                            ? CircularProgressIndicator(color: white)
                            : Text("Simpan", style: inter500(14, white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showSuketGaibDialog(BuildContext context, BerandaController bController) {
  Get.bottomSheet(
    backgroundColor: white,
    SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: 50.w,
              height: 3.h,
              color: abudebu,
              margin: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 4),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text("Data Terlapor",
                        style: montserrat600(16, black)),
                    SizedBox(height: 12.h),

                    // Input for NIK Terlapor
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.nikTerlaporController,
                      label: "NIK",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 14711***********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 4.h),
                    bController.kebenaran1.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn1.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.kewarganegaraanTerlaporController,
                      label: "Warga Negara Terlapor",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Indonesia",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.bulanHilangController,
                      label: "Bulan Hilang",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : January",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isPassword: false, 
                      isNumber: false,
                      textEditingC: bController.tahunHilangController, 
                      label: "Tahun Hilang", 
                      labelStyle: inter500(14, abupekat), 
                      hint: "cth : 2024",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 20.h),
                    Text("Data Pelapor", style: inter600(16, black)),
                    SizedBox(height: 12.h),

                    // Input for NIK Pelapor
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.nikPelaporController,
                      label: "NIK",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 14711***********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    const SizedBox(height: 4),
                    bController.kebenaran2.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn2.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.kewarganegaraanPelaporController,
                      label: "Warga Negara Pelapor",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Indonesia",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.hubunganPelaporController,
                      label: "Hubungan dengan Terlapor",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Anak",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      maxLines: 4,
                      textEditingC: bController.keteranganDialogController,
                      label: "Keperluan Surat",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Ganti KK",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 20.h),

                    // Submit Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketGaib();
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(sukses)),
                        child: bController.isLoading.value
                            ? CircularProgressIndicator(color: white)
                            : Text("Simpan", style: inter500(14, white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showSuketOrangYangSamaDialog(BuildContext context, BerandaController bController) {
  Get.bottomSheet(
    backgroundColor: white,
    SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Center(
            child: Container(
              width: 50.w,
              height: 3.h,
              color: abudebu,
              margin: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 4),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input NIK
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.nikPelaporController,
                      label: "NIK",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 14711***********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    // Dokumen yang benar
                    Text("Dokumen yang benar", style: inter500(14, black)),
                    DropdownButtonFormField<String>(
                      value: bController.selectedDokumenBenar.value,
                      style: inter500(13, black),
                      items: ["KTP", "KK", "Lainnya"]
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        bController.selectedDokumenBenar.value = value!;
                      },
                    ),
                    SizedBox(height: 4.h),
                    if (bController.selectedDokumenBenar.value == "KTP")
                      KolomInputan(
                        isNumber: true,
                        isPassword: false,
                        textEditingC: bController.nomorDokumenBenarController,
                        label: "NIK",
                        labelStyle: inter500(14, abupekat),
                        hint: "cth : 14711***********",
                        hintStyle: inter400(14, abupekat),
                      ),
                    if (bController.selectedDokumenBenar.value == "KK")
                      KolomInputan(
                        isNumber: true,
                        isPassword: false,
                        textEditingC: bController.nomorDokumenBenarController,
                        label: "Nomor KK",
                        labelStyle: inter500(14, abupekat),
                        hint: "cth : Masukkan Nomor KK",
                        hintStyle: inter400(14, abupekat),
                      ),
                    if (bController.selectedDokumenBenar.value == "Lainnya")
                      Column(
                        children: [
                          KolomInputan(
                            isNumber: false,
                            isPassword: false,
                            textEditingC: bController.namaDokumenBenarController,
                            label: "Nama Dokumen",
                            labelStyle: inter500(14, abupekat),
                            hint: "cth : Masukkan Nama Dokumen",
                            hintStyle: inter400(14, abupekat),
                          ),
                          SizedBox(height: 8.h),
                          KolomInputan(
                            isNumber: true,
                            isPassword: false,
                            textEditingC: bController.nomorDokumenBenarController,
                            label: "Nomor Dokumen",
                            labelStyle: inter500(14, abupekat),
                            hint: "Masukkan Nomor Dokumen",
                            hintStyle: inter400(14, abupekat),
                          ),
                        ],
                      ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.dataBenarController,
                      label: "Data Benar",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : SALMAN ANANDA",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    // Dokumen yang salah
                    Text("Dokumen yang salah", style: inter500(14, black)),
                    DropdownButtonFormField<String>(
                      value: bController.selectedDokumenSalah.value,
                      style: inter500(13, black),
                      items: ["KTP", "KK", "Lainnya"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (value) {
                        bController.selectedDokumenSalah.value = value!;
                      },
                    ),
                    SizedBox(height: 8.h),
                    if (bController.selectedDokumenSalah.value == "KTP")
                      KolomInputan(
                        isNumber: true,
                        isPassword: false,
                        textEditingC: bController.nomorDokumenSalahController,
                        label: "NIK",
                        labelStyle: inter500(14, abupekat),
                        hint: "cth : 14711***********",
                        hintStyle: inter400(14, abupekat),
                      ),
                    if (bController.selectedDokumenSalah.value == "KK")
                      KolomInputan(
                        isNumber: true,
                        isPassword: false,
                        textEditingC: bController.nomorDokumenSalahController,
                        label: "Nomor KK",
                        labelStyle: inter500(14, abupekat),
                        hint: "cth : Masukkan Nomor KK",
                        hintStyle: inter400(14, abupekat),
                      ),
                    if (bController.selectedDokumenSalah.value == "Lainnya")
                      Column(
                        children: [
                          KolomInputan(
                            isNumber: false,
                            isPassword: false,
                            textEditingC: bController.namaDokumenSalahController,
                            label: "Nama Dokumen",
                            labelStyle: inter500(14, abupekat),
                            hint: "Masukkan Nama Dokumen",
                            hintStyle: inter400(14, abupekat),
                          ),
                          SizedBox(height: 8.h),
                          KolomInputan(
                            isNumber: true,
                            isPassword: false,
                            textEditingC: bController.nomorDokumenSalahController,
                            label: "Nomor Dokumen",
                            labelStyle: inter500(14, abupekat),
                            hint: "Masukkan Nomor Dokumen",
                            hintStyle: inter400(14, abupekat),
                          ),
                        ],
                      ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                        isNumber: false,
                        isPassword: false,
                        textEditingC: bController.dataSalahController,
                        maxLines: 1,
                        label: "Data Salah",
                        labelStyle: inter500(14, abupekat),
                        hint: "cth : Salma Ananda",
                        hintStyle: inter400(14, abupekat),
                      ),
                    SizedBox(height: 4.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      maxLines: 3,
                      textEditingC: bController.keteranganDialogController,
                      label: "Keperluan Surat",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : administrasi pendukung beasiswa anak",
                      hintStyle: inter400(14, abupekat),
                    ),
                    // Button Simpan
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketOrangYangSama();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(sukses),
                        ),
                        child: bController.isLoading.value
                            ? CircularProgressIndicator(color: white)
                            : Text("Simpan", style: inter500(14, white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}




void showSuketDomisiliPerusahaanDialog(BuildContext context, BerandaController bController) {
  Get.bottomSheet(
    backgroundColor: Colors.white,
    SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: 50.w,
              height: 3.h,
              color: abudebu,
              margin: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 4),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NIK Input
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.namaPerusahaanController,
                      label: "Nama Perusahaan",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : PT. Sinar Budi",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.namaCustomController,
                      label: "Nama Penanggungjawab Perusahaan",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Budi Sutejo",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.jabatanCustomController,
                      label: "Jabatan di Perusahaan",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : CEO",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.nikPelaporController,
                      label: "NIK Penanggungjawab Perusahaan",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 14711***********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 4.h),
                    bController.kebenaran1.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn1.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.namaNotarisController,
                      label: "Nama Notaris Sertifikat",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Alfonso D Alburqueque, S.T., M.MT",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.noAktaController,
                      label: "Nomor Akta Sertifikat",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 132",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 16.w, left: 16.w),
                            height: 56.h,
                            child: Text("Tanggal Akta : ",
                                style: inter500(14, abupekat))),
                        Obx(() => Text(
                            bController.tanggal.value.isEmpty
                                ? "00/00/0000"
                                : bController.tanggal.value,
                            style: inter500(14, black))),
                        InkWell(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              bController.setTanggal(pickedDate);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: primary3,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Icon(Icons.date_range_outlined,
                                color: black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.alamatCustomController,
                      label: "Alamat Perusahaan",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Jl. Limbungan Strasse",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.rtCustomController,
                      label: "RT",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 02",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.rwCustomController,
                      label: "RW",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 10",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.noHpCustomController,
                      label: "Nomor Handphone",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 0812********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      maxLines: 4,
                      textEditingC: bController.keteranganDialogController,
                      label: "Keperluan Surat",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Pengajuan hak milik",
                      hintStyle: inter400(14, abupekat),
                    ),
                    const SizedBox(height: 24.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketDomisiliPerusahaan();
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(sukses)),
                        child: bController.isLoading.value
                            ? CircularProgressIndicator(color: white)
                            : Text("Simpan", style: inter500(14, white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showSuketDomisiliUsahaDialog(BuildContext context, BerandaController bController) {
  Get.bottomSheet(
    backgroundColor: Colors.white,
    SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: 50.w,
              height: 3.h,
              color: abudebu,
              margin: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.namaCustomController,
                      label: "Nama Pelapor",
                      labelStyle: inter500(14,abupekat),
                      hint: "cth : Budi Sutejo",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.nikPelaporController,
                      label: "NIK Pelapor",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 14711***********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 4.h),
                    bController.kebenaran1.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn1.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.tempatLahirCustomController,
                      label: "Kota Lahir",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Medan",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 16.w, left: 16.w),
                            height: 56.h,
                            child: Text("Tanggal Lahir : ",
                                style: inter500(14, abupekat))),
                        Obx(() => Text(
                            bController.tanggal.value.isEmpty
                                ? "00/00/0000"
                                : bController.tanggal.value,
                            style: inter500(14, black))),
                        InkWell(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              bController.setTanggal(pickedDate);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: primary3,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Icon(Icons.date_range_outlined,
                                color: black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Obx(() => DropdownButton<String>(
                      value: bController.agama.value.isEmpty? null : bController.agama.value,
                      isExpanded: true,
                      items: bController.listAgama.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) => bController.agama.value = value!,
                      hint: Text("Agama", style: inter500(14, abupekat)),
                    )),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.pekerjaanCustomController,
                      label: "Pekerjaan Pelapor",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Nelayan",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.alamatCustomController,
                      label: "Alamat Pelapor",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Jl. Jalan",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.jenisUsahaController,
                      label: "Jenis Usaha",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Kedai Harian",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.rtCustomController,
                      label: "RT",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 02",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.rwCustomController,
                      label: "RW",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 10",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.noHpCustomController,
                      label: "Nomor Handphone",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 0812********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      maxLines: 4,
                      textEditingC: bController.keteranganDialogController,
                      label: "Keperluan Suratr",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Pengajuan hak milik",
                      hintStyle: inter400(14, abupekat),
                    ),
                    const SizedBox(height: 24.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketDomisiliUsaha();
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(sukses)),
                        child: bController.isLoading.value
                            ? CircularProgressIndicator(color: white)
                            : Text("Simpan", style: inter500(14, white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showSuketTanggunganDialog(BuildContext context, BerandaController bController) {
  Get.bottomSheet(
    backgroundColor: Colors.white,
    SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: 50.w,
              height: 3.h,
              color: abudebu,
              margin: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 4),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input NIK
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.nikPelaporController,
                      label: "NIK",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 14711***********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    // Checkbox List
                    Text("Pilih Tanggungan :",
                        style: inter600(16, black)),
                    ...List.generate(
                      bController.checkboxItems.length,
                      (index) => CheckboxListTile(
                        title: Text(bController.checkboxItems[index],
                            style: inter500(14, black)),
                        value: bController.checkboxValues[index].value,
                        onChanged: (bool? value) {
                          bController.checkboxValues[index].value = value!;
                        },
                      ),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      maxLines: 4,
                      textEditingC: bController.keteranganDialogController,
                      label: "Keperluan Surat",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Pengajuan beasiswa",
                      hintStyle: inter400(14, abupekat),
                    ),
                    const SizedBox(height: 24.0),
                    // Button Simpan
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketTanggungan();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(sukses),
                        ),
                        child: bController.isLoading.value
                            ? CircularProgressIndicator(color: white)
                            : Text("Simpan", style: inter500(14, white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showSuketPindahWilayahDialog(BuildContext context, BerandaController bController) {
  Get.bottomSheet(
    backgroundColor: Colors.white,
    SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: 50.w,
              height: 3.h,
              color: abudebu,
              margin: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 4),
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input NIK
                    KolomInputan(
                      isNumber: true,
                      isPassword: false,
                      textEditingC: bController.nikPelaporController,
                      label: "NIK",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 14711***********",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      textEditingC: bController.nomorSPKTPController,
                      label: "Surat Pernyataan Kepemilikan/Penguasaan Tanah",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : 12/345/6/LB-SPKTP/XII/2020",
                      hintStyle: inter400(14, abupekat),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(top: 16.w, left: 16.w),
                            height: 56.h,
                            child: Text("Tanggal SPKTP : ",
                                style: inter500(14, abupekat))),
                        Obx(() => Text(
                            bController.tanggal.value.isEmpty
                                ? "00/00/0000"
                                : bController.tanggal.value,
                            style: inter500(14, black))),
                        InkWell(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              bController.setTanggal(pickedDate);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                                color: primary3,
                                borderRadius: BorderRadius.circular(4.r)),
                            child: Icon(Icons.date_range_outlined,
                                color: black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    KolomInputan(
                      isNumber: false,
                      isPassword: false,
                      maxLines: 4,
                      textEditingC: bController.keteranganDialogController,
                      label: "Keperluan Surat",
                      labelStyle: inter500(14, abupekat),
                      hint: "cth : Ganti KK",
                      hintStyle: inter400(14, abupekat),
                    ),
                    const SizedBox(height: 24.0),
                    // Button Simpan
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketPindahWilayah();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(sukses),
                        ),
                        child: bController.isLoading.value
                            ? CircularProgressIndicator(color: white)
                            : Text("Simpan", style: inter500(14, white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}