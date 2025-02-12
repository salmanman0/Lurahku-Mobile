import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../template/animate.dart';
import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../controllers/splash_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.checkLoginStatus();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: white,
        child: Column(
          children: [
            const Expanded(child: SizedBox.shrink()),
            TopIn(duration: const Duration(milliseconds: 1000), child: Image.asset('assets/logo.png', scale: 4,)),
            SizedBox(height: 50.h),
            RightIn(duration: const Duration(milliseconds: 1000), child: Text('LURAHKU', style: montserrat700(32, primary1),)),
            LeftIn(duration: const Duration(milliseconds: 1300), child: Text('Aplikasi Surat Menyurat', style: montserrat400(20, primary1),)),
            const Expanded(child: SizedBox.shrink()),
            Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: BottomIn(duration: const Duration(milliseconds: 500), child: Text('Limbungan', style: montserrat400(16, primary1),)),
            ),
          ],
        )
      )
    );
  }
}
