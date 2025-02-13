import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
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
                    Text("Data Terlapor",
                        style: montserrat600(16, black)),
                    SizedBox(height: 12.h),
                    // Input for NIK Terlapor
                    TextField(
                      controller: bController.nikTerlaporController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NIK Terlapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 14711xxxxxxxxxxx",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 4),

                    bController.kebenaran1.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn1.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    // Input for Kewarganegaraan Terlapor
                    TextField(
                      controller: bController.kewarganegaraanTerlaporController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Kewarganegaraan Terlapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : WNI",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Text("Data Hari Meninggal",
                        style: montserrat600(16, black)),
                    SizedBox(height: 12.h),

                    // Input for Hari Meninggal
                    TextField(
                      controller: bController.hariMeninggalController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Hari Meninggal",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Senin",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 4),

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
                    const SizedBox(height: 4),

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
                        child: TextField(
                          controller: bController.pukulMeninggalController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            labelText: "Pukul Meninggal (Waktu Setempat)",
                            labelStyle: inter500(14, abupekat),
                            contentPadding:
                                EdgeInsets.only(left: 16.w, top: 12.h),
                            filled: true,
                            fillColor: primary3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),

                    TextField(
                      controller: bController.tempatMeninggalController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Bertempat di",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Rumah",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Input for Penyebab Kematian
                    TextField(
                      controller: bController.penyebabMeninggalController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Penyebab Kematian",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Sakit",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Text("Data Pelapor", style: inter600(16, black)),
                    SizedBox(height: 12.h),

                    // Input for NIK Pelapor
                    TextField(
                      controller: bController.nikPelaporController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NIK Pelapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 14711***********",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),

                    const SizedBox(height: 4),
                    bController.kebenaran2.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn2.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),

                    TextField(
                      controller: bController.hubunganPelaporController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Hubungan dengan Terlapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Anak",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Input for Hubungan dengan Terlapor
                    TextField(
                      controller: bController.keteranganDialogController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Keperluan Surat",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Ganti KK",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
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
                    TextField(
                      controller: bController.nikPelaporController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NIK",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 14711***********",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
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
                    TextField(
                      controller: bController.penghasilanController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Penghasilan",
                        prefixText: "Rp. ",
                        hintText:
                            "cth :5.000.000 (jangan gunakan simbol titik atau koma)",
                        hintStyle: inter400(14, abupekat),
                        labelStyle: inter500(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.keteranganDialogController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: "Keperluan Surat",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : administrasi pendukung beasiswa anak",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketPenghasilan();
                          Get.back();
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
                    TextField(
                      controller: bController.nikPelaporController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NIK",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 14711***********",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    bController.kebenaran1.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn1.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),

                    TextField(
                      controller: bController.keteranganDialogController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: "Keperluan Surat",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : administrasi pendukung beasiswa anak",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketTidakMampu();
                          Get.back();
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
                    TextField(
                      controller: bController.nikTerlaporController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NIK Terlapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 14711xxxxxxxxxxx",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    bController.kebenaran1.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn1.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    TextField(
                      controller: bController.kewarganegaraanTerlaporController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Warga Negara Terlapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Indonesia",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: bController.bulanHilangController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Bulan Hilang",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Januari",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: bController.tahunHilangController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Tahun Hilang",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 2024",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text("Data Pelapor", style: inter600(16, black)),
                    SizedBox(height: 12.h),

                    // Input for NIK Pelapor
                    TextField(
                      controller: bController.nikPelaporController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NIK Pelapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 14711***********",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    bController.kebenaran2.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn2.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    TextField(
                      controller: bController.kewarganegaraanPelaporController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Warga Negara Pelapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Indonesia",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: bController.hubunganPelaporController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Hubungan dengan Terlapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Anak",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: bController.keteranganDialogController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Keperluan Surat",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Ganti KK",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
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
            height: MediaQuery.of(context).size.height * 0.7,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 4),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input NIK
                    TextField(
                      controller: bController.nikPelaporController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NIK Pelapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 14711***********",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
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
                      TextField(
                        controller: bController.nomorDokumenBenarController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "NIK",
                          labelStyle: inter500(14, abupekat),
                          hintText: "Masukkan NIK",
                          hintStyle: inter400(14, abupekat),
                          filled: true,
                          fillColor: primary3,
                        ),
                      ),
                    if (bController.selectedDokumenBenar.value == "KK")
                      TextField(
                        controller: bController.nomorDokumenBenarController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Nomor KK",
                          labelStyle: inter500(14, abupekat),
                          hintText: "Masukkan Nomor KK",
                          hintStyle: inter400(14, abupekat),
                          filled: true,
                          fillColor: primary3,
                        ),
                      ),
                    if (bController.selectedDokumenBenar.value == "Lainnya")
                      Column(
                        children: [
                          TextField(
                            controller: bController.namaDokumenBenarController,
                            decoration: InputDecoration(
                              labelText: "Nama Dokumen",
                              labelStyle: inter500(14, abupekat),
                              hintText: "Masukkan Nama Dokumen",
                              hintStyle: inter400(14, abupekat),
                              filled: true,
                              fillColor: primary3,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          TextField(
                            controller: bController.nomorDokumenBenarController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Nomor Dokumen",
                              labelStyle: inter500(14, abupekat),
                              hintText: "Masukkan Nomor Dokumen",
                              hintStyle: inter400(14, abupekat),
                              filled: true,
                              fillColor: primary3,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.dataBenarController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Data Benar",
                        labelStyle: inter500(14, abupekat),
                        hintText: "Data yang benar (cth : SALMAN ANANDA)",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
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
                    SizedBox(height: 4.h),
                    if (bController.selectedDokumenSalah.value == "KTP")
                      TextField(
                        controller: bController.nomorDokumenSalahController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "NIK",
                          labelStyle: inter500(14, abupekat),
                          hintText: "Masukkan NIK",
                          hintStyle: inter400(14, abupekat),
                          filled: true,
                          fillColor: primary3,
                        ),
                      ),
                    if (bController.selectedDokumenSalah.value == "KK")
                      TextField(
                        controller: bController.nomorDokumenSalahController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Nomor KK",
                          labelStyle: inter500(14, abupekat),
                          hintText: "Masukkan Nomor KK",
                          hintStyle: inter400(14, abupekat),
                          filled: true,
                          fillColor: primary3,
                        ),
                      ),
                    if (bController.selectedDokumenSalah.value == "Lainnya")
                      Column(
                        children: [
                          TextField(
                            controller: bController.namaDokumenSalahController,
                            decoration: InputDecoration(
                              labelText: "Nama Dokumen",
                              labelStyle: inter500(14, abupekat),
                              hintText: "Masukkan Nama Dokumen",
                              hintStyle: inter400(14, abupekat),
                              filled: true,
                              fillColor: primary3,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          TextField(
                            controller: bController.nomorDokumenSalahController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Nomor Dokumen",
                              labelStyle: inter500(14, abupekat),
                              hintText: "Masukkan Nomor Dokumen",
                              hintStyle: inter400(14, abupekat),
                              filled: true,
                              fillColor: primary3,
                            ),
                          ),
                        ],
                      ),
                    
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.dataSalahController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Data Salah",
                        labelStyle: inter500(14, abupekat),
                        hintText: "Data yang salah (cth : Salma Ananda)",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.keteranganDialogController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Keperluan Surat",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Ganti KK",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    // Button Simpan
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketOrangYangSama();
                          Get.back();
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
                    TextField(
                      controller: bController.namaPerusahaanController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nama Perusahaan",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : PT. Sinar Budi",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.namaCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nama Penanggungjawab Perusahaan",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Budi Sutejo",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.jabatanCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Jabatan di Perusahaan",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : CEO",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.nikPelaporController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NIK Penanggungjawab Perusahaan",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 14711*********",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    bController.kebenaran1.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn1.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    TextField(
                      controller: bController.namaNotarisController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nama Notaris Sertifikat",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Alfonso D Alburqueque, S.T., M.T",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.noAktaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Nomor Akta Sertifikat",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 132",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
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
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.alamatCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Alamat Perusahaan",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Jl. Limbungan Strasse",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.rtCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "RT",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 02",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.rwCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "RW",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 10",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.noHpCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nomor Handphone",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 0812*****",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.keteranganDialogController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: "Keperluan Surat",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : pengajuan hak milik",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
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
                    TextField(
                      controller: bController.namaCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nama Pelapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Budi Sutejo",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.nikPelaporController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NIK Pelapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 14711***********",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    bController.kebenaran1.value
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(bController.warn1.value,
                                style: inter600(12, gagal)),
                          )
                        : const SizedBox.shrink(),
                    TextField(
                      controller: bController.tempatLahirCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Kota Lahir",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Medan",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
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
                    TextField(
                      controller: bController.agamaCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Agama Pelapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Islam",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.pekerjaanCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Pekerjaan Pelapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Nelayan",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.alamatCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Alamat Pelapor",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Jl. Jalan",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.jenisUsahaController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Jenis Usaha",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Kedai Harian",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.rtCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "RT",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 02",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.rwCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "RW",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 10",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.noHpCustomController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Nomor Handphone",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 0812*****",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.keteranganDialogController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: "Keperluan Surat",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : pengajuan hak milik",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
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
                    TextField(
                      controller: bController.nikPelaporController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NIK",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 14711***********",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
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
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.keteranganDialogController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Keperluan Surat",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Pengajuan beasiswa",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    // Button Simpan
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketTanggungan();
                          Get.back();
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
                    TextField(
                      controller: bController.nikPelaporController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "NIK",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 14711***********",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.nomorSPKTPController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Surat Pernyataan Kepemilikan/ Penguasaan Tanah",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : 12/345.6/LB-SPKPT/XII/2020",
                        hintStyle: inter400(14, abupekat),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    SizedBox(height: 4.h),
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
                    SizedBox(height: 4.h),
                    TextField(
                      controller: bController.keteranganDialogController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Keperluan Surat",
                        labelStyle: inter500(14, abupekat),
                        hintText: "cth : Ganti KK",
                        hintStyle: inter400(14, abupekat),
                        contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                        filled: true,
                        fillColor: primary3,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    // Button Simpan
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          bController.postSuketPindahWilayah();
                          Get.back();
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