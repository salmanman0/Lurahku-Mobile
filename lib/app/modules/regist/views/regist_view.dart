import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../../../template/kolom_inputan.dart';
import '../controllers/regist_controller.dart';

class RegistView extends GetView<RegistController> {
  const RegistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,  
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(  
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Daftar Akun',
                  style: inter500(32, black),
                ),
                Text(
                  'Kenalan dulu yuk,\nMasukkan data diri anda untuk mendaftar',
                  style: inter400(16, abupekat),
                ),
                const SizedBox(height: 40),
                KolomInputan(
                  label: 'Email', 
                  labelStyle: inter400(16, abupekat), 
                  isPassword: false, 
                  textEditingC: controller.emailTEC,
                  isNumber: false,
                ),
                const SizedBox(height: 20),
                KolomInputan(
                  label: 'Nomor kartu keluarga', 
                  labelStyle: inter400(16, abupekat), 
                  isPassword: false, 
                  textEditingC: controller.noKKTEC,
                  isNumber: true,
                ),
                const SizedBox(height: 20),
                KolomInputan(
                  label: 'Password', 
                  labelStyle: inter400(16, abupekat), 
                  isPassword: true, 
                  textEditingC: controller.passwordTEC,
                  maxLines: 1, 
                  isPeek: controller.isPeek1, 
                  obsecure: controller.lihat1, 
                  obsecureChar: '*',
                  isNumber: false,
                ),
                const SizedBox(height: 20),
                KolomInputan(
                  label: 'Ulangi password', 
                  labelStyle: inter400(16, abupekat), 
                  isPassword: true, 
                  textEditingC: controller.confirmPassTEC, 
                  maxLines: 1, 
                  isPeek: controller.isPeek2, 
                  obsecure: controller.lihat2, 
                  obsecureChar: '*',
                  isNumber: false,
                ),
                Obx(() => Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: controller.warn.value
                      ? Text(controller.note.value, style: inter600(14, gagal))
                      : const SizedBox(height: 16),
                )),
                SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.register,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(primary1),
                      shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Daftar', style: inter500(18, white)),
                        Obx(() {
                          return controller.isLoading.value
                              ? CircularProgressIndicator(color: white)
                              : Icon(Icons.arrow_circle_right_rounded, color: white);
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: Row(
                    children: [
                      Text('Sudah punya akun?', style: inter400(16, black)),
                      TextButton(
                        onPressed: () => Get.offNamed(Routes.LOGIN),
                        child: Text('Masuk', style: inter400(16, biru)),
                      ),
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
