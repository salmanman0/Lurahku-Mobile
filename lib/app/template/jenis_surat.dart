import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_app.dart';
import 'font_app.dart';

class JenisSurat extends StatelessWidget {
  final String gambar;
  final String text1;
  final String text2;
  final String keterangan;
  final Function dialogInputan;

  const JenisSurat({
    super.key,
    required this.gambar,
    required this.text1,
    required this.text2,
    required this.keterangan,
    required this.dialogInputan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      margin: EdgeInsets.only(bottom: 8.h),
      child: ElevatedButton(
        onPressed: ()=>dialogInputan(),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(primary1),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r))),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icon-surat/$gambar',
                  scale: 14.r,
                ),
                SizedBox(width: 8.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text1,style: montserrat500(12, white)),
                    Text(text2, style: montserrat600(16, white)),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      keterangan,
                      style: montserrat400(12, white),
                    ),
                    duration: const Duration(seconds: 4),
                  ),
                );
              },
              child: Image.asset('assets/icon-surat/info.png', scale: 20.r),
            ),
          ],
        ),
      ),
    );
  }
}
