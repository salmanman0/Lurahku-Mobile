import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lurahku_remake/app/modules/datadiri/controllers/datadiri_controller.dart';
import 'package:lurahku_remake/app/template/color_app.dart';
import 'package:lurahku_remake/app/template/font_app.dart';

class AnggotaCard extends StatelessWidget {
  final String nama;
  final String nik;
  final String tempatLahir;
  final String peran;
  final String jenisKelamin;
  final String tanggalLahir;
  final String agama;
  final String pendidikan;
  final String golDarah;
  final String pekerjaan;
  final String statusPerkawinan;
  final int wargaId;

  AnggotaCard({
    super.key,
    required this.nama,
    required this.nik,
    required this.tempatLahir,
    required this.peran,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.agama,
    required this.pendidikan,
    required this.golDarah,
    required this.pekerjaan,
    required this.statusPerkawinan,
    required this.wargaId,
  });

  final DatadiriController controller = Get.put(DatadiriController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 183.w,
      padding: EdgeInsets.only(top: 12.r, left: 24.w, right: 12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [white, biru],
          stops: const [0.8, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.3),
            blurRadius: 1,
            offset: const Offset(4, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Bungkus Column ini dengan Expanded atau Flexible agar teks nama dan nik tidak melampaui lebar container
              Expanded(
                child: Text(
                  nama,
                  style: montserrat600(16, black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (String value) {
                  if (value == 'Ubah') {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.namaController.text = nama;
                      controller.nikController.text = nik;
                      controller.tempatLahirController.text = tempatLahir;
                      controller.peran.value = peran;
                      controller.jenisKelamin.value = jenisKelamin;
                      controller.tanggalLahir.value = tanggalLahir;
                      controller.agama.value = agama;
                      controller.pendidikan.value = pendidikan;
                      controller.golonganDarah.value = golDarah;
                      controller.pekerjaan.value = pekerjaan;
                      controller.statusPerkawinan.value = statusPerkawinan;
                    });
                    _showUpdateAnggotaDialog(context, wargaId);
                  } else if (value == 'Hapus') {
                    controller.deleteKeluarga(wargaId);
                    Future.delayed(const Duration(milliseconds: 500), () {
                      controller.getKeluarga();
                    });
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'Ubah',
                    child: Text('Ubah'),
                  ),
                  const PopupMenuItem(
                    value: 'Hapus',
                    child: Text('Hapus'),
                  ),
                ],
                child: Container(
                  height: 36,
                  width: 48,
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.more_vert,color: black, size: 18.r,),
                ),
              ),
            ],
          ),
          Text(nik,style: montserrat500(10, abupekat),maxLines: 1,overflow: TextOverflow.ellipsis),
          SizedBox(height: 8.h),
          Text(peran, style: montserrat500(12, abupekat)),
          Text(jenisKelamin, style: montserrat500(12, black)),
          Text("${tempatLahir.split(',').first}, $tanggalLahir", style: montserrat500(12, black)),
          Text(agama, style: montserrat500(12, black)),
          Text(pendidikan, style: montserrat500(12, black)),
          Text(golDarah, style: montserrat500(12, black)),
          Text(pekerjaan, style: montserrat500(12, black)),
        ],
      ),
    );
  }

  void _showUpdateAnggotaDialog(BuildContext context, int wargaId) {
    Get.bottomSheet(
      backgroundColor: white,
      SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller.namaController,
              decoration: InputDecoration(
                labelText: "Nama",
                labelStyle: inter500(14, abupekat),
                contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                filled: true,
                fillColor: primary3,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: controller.nikController,
              decoration: InputDecoration(
                labelText: "NIK",
                labelStyle: inter500(14, abupekat),
                contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                filled: true,
                fillColor: primary3,
              ),
            ),
            Obx(() => controller.galat.value? SizedBox(width: MediaQuery.of(context).size.width, child: Text(controller.warn.value, style: inter400(12, gagal))) : const SizedBox.shrink()),
            const SizedBox(height: 4),
            TextField(
              controller: controller.tempatLahirController,
              decoration: InputDecoration(
                labelText: "Tempat Lahir",
                labelStyle: inter500(14, abupekat),
                hintText: "Kota, Provinsi, Negara (gunakan tanda koma)",
                hintStyle: inter400(12, abupekat),
                contentPadding: EdgeInsets.only(left: 16.w, top: 12.h),
                filled: true,
                fillColor: primary3,
              ),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tanggal Lahir : ", style: inter500(14, abupekat)),
                Obx(() => Text(controller.tanggalLahir.value.isEmpty? "00/00/0000": controller.tanggalLahir.value,style: inter500(14, black))),
                Row(
                  children: [
                    
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
              ],
            ),
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
                  controller.updateKeluarga(
                      wargaId,
                      controller.namaController.text,
                      controller.nikController.text,
                      controller.tempatLahirController.text,
                      controller.peran.value,
                      controller.jenisKelamin.value,
                      controller.pendidikan.value,
                      controller.golonganDarah.value,
                      controller.pekerjaan.value,
                      controller.agama.value,
                      controller.statusPerkawinan.value,
                      controller.tanggalLahir.value);
                    Future.delayed(const Duration(milliseconds: 250), () {
                      controller.getKeluarga();
                    });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(sukses),
                ),
                child: Text("Simpan", style: inter500(14, white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
