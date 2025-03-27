import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lurahku_remake/app/template/color_app.dart';
import 'package:lurahku_remake/app/template/font_app.dart';

class ListKetua extends StatelessWidget {
  final String gambar;
  final String nama;
  final String jabatan;
  final String rt;
  final String rw;
  final String noHp;
  final String alamat;
  String keterangan;

  ListKetua({
    super.key,
    required this.gambar,
    required this.nama,
    required this.jabatan,
    required this.rt,
    required this.rw,
    required this.noHp,
    required this.alamat,
    this.keterangan = '',
  });

  @override
  Widget build(BuildContext context) {
    if(jabatan == 'Ketua RW'){
      keterangan = '$jabatan $rw';
    }
    else if(jabatan == 'Ketua RT'){
      keterangan = '$jabatan $rt';
    }
    else{
      keterangan = '';
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 20.w,right: 20.w, top: 12.h),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 150.w,
            height: 170.h,
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r)),
              image: DecorationImage(
                image: NetworkImage(gambar),
                fit: BoxFit.cover,
                scale: 12.r,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 8.h, right: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    nama,
                    style: montserrat600(16, black),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Text(keterangan, style: montserrat600(14, abupekat)),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 12.r, color: abupekat),
                    SizedBox(width: 4.w),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(alamat, style: montserrat500(12, abupekat), maxLines: 2, overflow: TextOverflow.ellipsis,)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.phone, size: 12.r, color: abupekat),
                    SizedBox(width: 4.w),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,                      
                      child: Text(noHp, style: montserrat500(12, abupekat))),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.person_pin_rounded, size: 12.r, color: abupekat),
                    SizedBox(width: 4.w),
                    Text('RT $rt RW $rw', style: montserrat500(12, abupekat)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
