import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../../../template/kolom_inputan.dart';
import '../controllers/forget_controller.dart';

class ForgetView extends GetView<ForgetController> {
  const ForgetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: white,
      padding: EdgeInsets.symmetric(horizontal: 44.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(child: SizedBox.shrink()),
          Text('Lupa Password', style: inter500(32, black)),
          Text('Verifikasi email,\nSilahkan masukkan email terdaftar anda',
              style: inter400(16, abupekat)),
          SizedBox(height: 40.h),
          KolomInputan(
                label: 'Email',
                labelStyle: inter400(16, abupekat),
                isPassword: false,
                textEditingC: controller.emailTEC,
                isNumber: false,
              ),
          Obx(
            () => Container(
              margin: EdgeInsets.only(top: 4.h),
              width: MediaQuery.of(context).size.width * 0.6,
              child: controller.warn.value
                  ? Text(controller.note.value, style: inter500(12, controller.warna))
                  : const SizedBox.shrink(),
            ),
          ),
          SizedBox(height: 40.h),
          SizedBox(
            height: 60.h,
            child: ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.forgotPassword,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primary1),
                  shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Verifikasi',
                      style: inter500(18, white),
                    ),
                    Obx(() {
                      return controller.isLoading.value
                          ? CircularProgressIndicator(color: white)
                          : Icon(Icons.arrow_circle_right_rounded,
                              color: white);
                    }),
                  ],
                )),
          ),
          const Expanded(child: SizedBox.shrink()),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: Row(
              children: [
                Text('Kembali ke halaman login?',
                    style: inter400(16, black)),
                TextButton(
                    onPressed: () => Get.offNamed(Routes.LOGIN),
                    child: Text(
                      'Masuk',
                      style: inter400(16, biru),
                    ))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
