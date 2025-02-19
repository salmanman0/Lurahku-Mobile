import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../controllers/konfirmasi_warga_controller.dart';

class ListKonfirmasiWarga extends StatelessWidget {
  final String gambar;
  final String nama;
  final String noKK;
  final String nik;
  final String alamat;
  final String noHp;
  final String gambarKK;
  final int rekomId;
  final KonfirmasiWargaController controller;

  const ListKonfirmasiWarga({
    super.key,
    required this.gambar,
    required this.nama,
    required this.noKK,
    required this.nik,
    required this.alamat,
    required this.noHp,
    required this.gambarKK,
    required this.rekomId,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 4.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            offset: const Offset(0, 3),
            blurRadius: 2,
            spreadRadius: 2,
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: backgroundScreen,
                backgroundImage: NetworkImage(gambar),
              ),
              SizedBox(width: 12.h),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nama, style: inter500(14, black)),
                    Text(noKK, style: inter500(12, abupekat)),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => _showDetailDialog(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.info_outline, color: biru),
              ),
              IconButton(
                onPressed: () {
                  controller.deleteRekom(rekomId);
                  Future.delayed(const Duration(milliseconds: 250), () {
                      controller.getRekom();
                  });
                }, 
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.close, color: gagal),
              ),
              IconButton(
                onPressed: () {
                  controller.updateRekom(rekomId, "diterima");
                  Future.delayed(const Duration(milliseconds: 250), () {
                      controller.getRekom();
                    });
                }, 
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.check, color: sukses),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDetailDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView( 
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 70.w,
                    backgroundImage: NetworkImage(gambar),
                  ),
                ),
                SizedBox(height: 16.h),
                Center(child: Text(nama, style: inter500(20, black))),
                SizedBox(height: 16.h),
                Text("Nomor Kartu Keluarga", style: inter600(16, black)),
                Text(noKK, style: inter400(16, black)),
                SizedBox(height: 8.h),
                Text("Nomor Induk Kependudukan", style: inter600(16, black)),
                Text(nik, style: inter400(16, black)),
                SizedBox(height: 8.h),
                Text("Alamat", style: inter600(16, black)),
                Text(alamat, style: inter400(16, black)),
                SizedBox(height: 8.h),
                Text("Nomor HP", style: inter600(16, black)),
                Text(noHp, style: inter400(16, black)),
                SizedBox(height: 8.h),
                Text("Gambar Kartu Keluarga", style: inter600(16, black)),
                InteractiveViewer(
                  panEnabled: true, 
                  minScale: 1.0, 
                  maxScale: 5.0, 
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Image.network(
                      gambarKK,
                      fit: BoxFit.contain, 
                    ),
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


}
