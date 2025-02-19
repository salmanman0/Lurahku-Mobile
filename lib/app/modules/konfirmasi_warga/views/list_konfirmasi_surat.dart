import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../../konfirmasi_warga/views/dialog.dart';
import '../controllers/konfirmasi_warga_controller.dart';

class ListKonfirmasiSurat extends StatelessWidget {
  final Map<String, dynamic> dataSurat;
  final KonfirmasiWargaController controller;

  const ListKonfirmasiSurat({
    super.key,
    required this.dataSurat,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 4.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(color: white, boxShadow: [
        BoxShadow(
          color: black.withOpacity(0.2),
          offset: const Offset(0, 3),
          blurRadius: 2,
          spreadRadius: 2,
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 12.h),
              
            ],
          ),
          
        ],
      ),
    );
  }

  
}
