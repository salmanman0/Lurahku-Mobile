import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lurahku_remake/app/template/anggota_card.dart';
import 'package:lurahku_remake/app/template/color_app.dart';
import 'package:lurahku_remake/app/template/font_app.dart';
import 'package:lurahku_remake/app/template/kolom_inputan.dart';

import '../controllers/datadiri_controller.dart';

class TambahAnggota extends StatelessWidget {
  TambahAnggota({super.key});
  final DatadiriController controller = Get.find<DatadiriController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anggota Keluarga', style: montserrat600(16, black)),
        backgroundColor: white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTambahAnggotaDialog(context);
        },
        backgroundColor: sukses,
        child: Icon(Icons.add, color: white),
      ),
      body: RefreshIndicator(
        onRefresh: controller.getKeluarga,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16.r),
          color: backgroundScreen,
          child: Obx(() {
            if (controller.keluarga.isEmpty) {
              return Center(child: Text("Keluarga belum ditambahkan", style: inter500(16, abupekat),));  // Loading indicator if data is empty
            }
            // Display the data in GridView
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: controller.keluarga.length,
              itemBuilder: (context, index) {
                var anggota = controller.keluarga[index];
                return AnggotaCard(
                  nama: anggota['nama']??"Nama Tidak Tersedia",
                  nik: anggota['nik']??"NIK Tidak Tersedia",
                  peran: anggota['peran']??"Tersedia",
                  jenisKelamin: anggota['jenis_kelamin']??"Tidak Tersedia",
                  tanggalLahir: anggota['ttl']??"Tidak Tersedia",
                  agama: anggota['agama']??"Tidak Tersedia",
                  tempatLahir: anggota['tempat_lahir']??"Tidak Tersedia",
                  pendidikan: anggota['pendidikan']??"Tidak Tersedia",
                  golDarah: anggota['gol_darah']??"Tidak Tersedia",
                  pekerjaan: anggota['pekerjaan']??"Tidak Tersedia",
                  statusPerkawinan: anggota['status_perkawinan']??"Belum Kawin",
                  wargaId: anggota['wargaId']??"Tidak Tersedia",
                );
              },
            );
          }),
        ),
      ),
    );
  }

  void _showTambahAnggotaDialog(BuildContext context) {
    Get.bottomSheet(
      backgroundColor: white,
      SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KolomInputan(label: "Nama", labelStyle: inter500(14, abupekat), textEditingC: controller.namaController, isPassword: false, isNumber: false, hint: "cth : Jhon Due", hintStyle: inter400(12, abupekat)),
            const SizedBox(height: 4),
            KolomInputan(label: "NIK", labelStyle: inter500(14, abupekat), textEditingC: controller.nikController, isPassword: false, isNumber: false, hint: "cth : 14711***********",hintStyle: inter400(12, abupekat)),
            Obx(()=>controller.galat.value? Container(width: MediaQuery.of(context).size.width, padding: EdgeInsets.only(top:4.w), child: Text(controller.warn.value, style: inter400(12, gagal), textAlign: TextAlign.left,)) : const SizedBox.shrink()),
            const SizedBox(height: 4),
            KolomInputan(label: "Tempat Lahir", labelStyle: inter500(14, abupekat), textEditingC: controller.tempatLahirController, isPassword: false, isNumber: false, hint: "Kota, Provinsi, Negara (wajib gunakan tanda koma)", hintStyle: inter400(12, abupekat)),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tanggal Lahir : ", style: inter500(14, abupekat)),
                Obx(() => Text(controller.tanggalLahir.value.isEmpty? "00/00/0000": controller.tanggalLahir.value,style: inter500(14, black))),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      controller.setTanggalLahir(pickedDate);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: primary3,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.date_range_outlined,
                        color: black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Obx(() => DropdownButton<String>(
                  value: controller.peran.value.isEmpty? null: controller.peran.value,
                  isExpanded: true,
                  items: ['Kepala Keluarga', 'Anggota'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => controller.peran.value = value!,
                  hint: Text("Peran", style: inter500(14, abupekat)),
                )),
            const SizedBox(height: 4),
            Obx(() => DropdownButton<String>(
                  value: controller.jenisKelamin.value.isEmpty? null: controller.jenisKelamin.value,
                  isExpanded: true,
                  items: ['Laki-Laki', 'Perempuan'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => controller.jenisKelamin.value = value!,
                  hint: Text("Jenis Kelamin", style: inter500(14, abupekat)),
                )),
            const SizedBox(height: 4),
            Obx(() => DropdownButton<String>(
                  value: controller.agama.value.isEmpty? null : controller.agama.value,
                  isExpanded: true,
                  items: controller.listAgama.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => controller.agama.value = value!,
                  hint: Text("Agama", style: inter500(14, abupekat)),
                )),
            const SizedBox(height: 4),
            Obx(() => DropdownButton<String>(
                  value: controller.statusPerkawinan.value.isEmpty? null : controller.statusPerkawinan.value,
                  isExpanded: true,
                  items: controller.listStatusPerkawinan.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => controller.statusPerkawinan.value = value!,
                  hint: Text("Status Perkawinan", style: inter500(14, abupekat)),
                )),
            const SizedBox(height: 4),
            Obx(() => DropdownButton<String>(
                  value: controller.pendidikan.value.isEmpty? null: controller.pendidikan.value,
                  isExpanded: true,
                  items: controller.listPendidikan.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => controller.pendidikan.value = value!,
                  hint: Text("Pendidikan", style: inter500(14, abupekat)),
                )),
            const SizedBox(height: 4),
            Obx(() => DropdownButton<String>(
                  value: controller.golonganDarah.value.isEmpty? null: controller.golonganDarah.value,
                  isExpanded: true,
                  items: controller.listGolDar.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => controller.golonganDarah.value = value!,
                  hint: Text("Golongan Darah", style: inter500(14, abupekat)),
                )),
            const SizedBox(height: 4),
            Obx(() => DropdownButton<String>(
                  value: controller.pekerjaan.value.isEmpty? null: controller.pekerjaan.value,
                  isExpanded: true,
                  items: controller.listPekerjaan.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => controller.pekerjaan.value = value!,
                  hint: Text("Pekerjaan", style: inter500(14, abupekat)),
                )),
            SizedBox(height: 20.h),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  controller.postKeluarga(
                      controller.namaController.text,
                      controller.nikController.text,
                      controller.tempatLahirController.text,
                      controller.tanggalLahir.value,
                      controller.peran.value,
                      controller.jenisKelamin.value,
                      controller.pendidikan.value,
                      controller.golonganDarah.value,
                      controller.pekerjaan.value,
                      controller.agama.value,
                      controller.statusPerkawinan.value);
                    Future.delayed(const Duration(milliseconds: 500), () {
                      controller.getKeluarga();
                    });
                },
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(sukses)),
                child: controller.isLoading.value? CircularProgressIndicator(color: white) : Text("Simpan", style: inter500(14, white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
