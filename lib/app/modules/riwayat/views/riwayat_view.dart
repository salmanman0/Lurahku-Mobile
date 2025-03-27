import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lurahku_remake/app/template/color_app.dart';
import 'package:lurahku_remake/app/template/font_app.dart';
import 'package:lurahku_remake/app/template/riwayat_surat.dart';

import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  RiwayatView({super.key});
  final RiwayatController rController = Get.put(RiwayatController());

  @override
  Widget build(BuildContext context) {
    rController.getRiwayat();
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pengurusan Surat',
            style: montserrat600(16, black)),
        foregroundColor: white,
        backgroundColor: white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: backgroundScreen,
        padding: EdgeInsets.only(top: 8.h),
        child: Obx(() {
          return rController.riwayat.isEmpty
              ? ListView(
                  // Empty ListView to allow scroll behavior
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Tidak ada riwayat surat',
                          style: montserrat600(14, black),
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: rController.riwayat.length,
                  itemBuilder: (context, index) {
                    final riwayatItem = rController
                        .riwayat[rController.riwayat.length - index - 1];
                    return RiwayatSurat(
                      surat: riwayatItem['jenis_surat'] ?? 'Tidak diketahui',
                      tanggal: '${riwayatItem['waktu'] ?? 'Tidak diketahui'}',
                      status: riwayatItem['status_surat'] ?? 'Tidak diketahui',
                      keterangan: riwayatItem['catatan'] ?? '',
                    );
                  },
                );
        }),
      ),
    );
  }
}
