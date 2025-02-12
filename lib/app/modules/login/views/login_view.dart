import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../../../template/kolom_inputan.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Menyelesaikan masalah keyboard
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            // Mengatasi tampilan yang overflow saat keyboard muncul
            padding: EdgeInsets.symmetric(horizontal: 44.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h), // Memberi jarak dari atas
                Text(
                  'Masuk',
                  style: inter500(32, black),
                ),
                Text(
                  'Selamat datang,\nMasukkan email dan kata sandi anda',
                  style: inter400(16, abupekat),
                ),
                SizedBox(height: 40.h),
                KolomInputan(
                    label: "Nomor KK",
                    labelStyle: inter400(16, abupekat),
                    textEditingC: controller.noKKTEC,
                    isPassword: false,
                    isNumber: true),
                SizedBox(height: 40.h),
                KolomInputan(
                    label: "Password",
                    labelStyle: inter400(16, abupekat),
                    textEditingC: controller.passwordTEC,
                    isPassword: true,
                    isNumber: false,
                    isPeek: controller.isPeek,
                    obsecure: controller.lihat,
                    obsecureChar: "*"),
                Obx(() => Container(
                    margin: EdgeInsets.only(top: 4.h),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: controller.warn.value
                        ? Text(controller.note.value,
                            style: inter500(12, gagal))
                        : const SizedBox.shrink())),
                SizedBox(height: 30.h),
                SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed:  controller.isLoading.value ? null : controller.login,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(primary1),
                      shape: const WidgetStatePropertyAll(
                          RoundedRectangleBorder()),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Masuk',
                          style: inter500(18, white),
                        ),
                        Obx(() {
                          return controller.isLoading.value
                              ? CircularProgressIndicator(
                                  color: white,
                                )
                              : Icon(
                                  Icons.arrow_circle_right_rounded,
                                  color: white,
                                );
                        }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                TextButton(
                    onPressed: () => Get.toNamed(Routes.FORGET),
                    child: Text(
                      'Lupa Password?',
                      style: inter400(16, biru),
                    )),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: Row(
                    children: [
                      Text(
                        'Belum punya akun?',
                        style: inter400(16, black),
                      ),
                      TextButton(
                          onPressed: () => Get.toNamed(Routes.REGIST),
                          child: Text(
                            'Daftar',
                            style: inter400(16, biru),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
