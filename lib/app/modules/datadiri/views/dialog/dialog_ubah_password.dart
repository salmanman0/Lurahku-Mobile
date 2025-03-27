import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lurahku_remake/app/modules/datadiri/controllers/datadiri_controller.dart';
import 'package:lurahku_remake/app/template/color_app.dart';
import 'package:lurahku_remake/app/template/font_app.dart';

void showUbahPasswordDialog(BuildContext context) {
  final DatadiriController controller = Get.put(DatadiriController());

  Get.defaultDialog(
    backgroundColor: white,
    title: "Ubah Password",
    titleStyle: montserrat600(18, black),
    content: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input Password Baru
          Obx(() => TextField(
                obscureText: controller.lihat1.value,
                decoration: InputDecoration(
                  labelText: "Password Baru",
                  labelStyle: inter400(14, abupekat),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: controller.isPeek1,
                    icon: Icon(controller.lihat1.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  suffix: controller.newPassword.value.length >= 8
                      ? Icon(Icons.check_circle, color: sukses, size: 18)
                      : const Icon(Icons.warning, color: Colors.orange, size: 18),
                ),
                onChanged: (value) {
                  controller.newPassword.value = value;
                  controller.checkPasswordMatch();
                },
              )),
          SizedBox(height: 12.h),

          // Input Konfirmasi Password
          Obx(() => TextField(
                obscureText: controller.lihat2.value,
                decoration: InputDecoration(
                  labelText: "Ulangi Password Baru",
                  labelStyle: inter400(14, abupekat),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: controller.isPeek2,
                    icon: Icon(controller.lihat2.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  suffix: controller.confirmPassword.value.isNotEmpty &&
                          controller.isPasswordMatch.value
                      ? Icon(Icons.check_circle, color: sukses, size: 18)
                      : null,
                ),
                onChanged: (value) {
                  controller.confirmPassword.value = value;
                  controller.checkPasswordMatch();
                },
              )),
          SizedBox(height: 10.h),

          // Indikator Kekuatan Password
          Obx(() {
            int length = controller.newPassword.value.length;
            Color strengthColor;
            String strengthText;

            if (length == 0) {
              return const SizedBox.shrink();
            } else if (length < 6) {
              strengthColor = Colors.red;
              strengthText = "Lemah";
            } else if (length < 8) {
              strengthColor = Colors.orange;
              strengthText = "Sedang";
            } else {
              strengthColor = sukses;
              strengthText = "Kuat";
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Kekuatan: ", style: inter400(12, black)),
                Text(strengthText, style: inter500(12, strengthColor)),
              ],
            );
          }),
          SizedBox(height: 16.h),

          // Pesan validasi password
          Obx(() => controller.isPasswordMatch.value
              ? Text("Password cocok", style: inter500(12, sukses))
              : const SizedBox.shrink()),

          SizedBox(height: 20.h),

          // Tombol Simpan
          Obx(() => Center(
            child: ElevatedButton(
                  onPressed: (controller.isPasswordMatch.value &&
                          controller.newPassword.value.length >= 8)
                      ? () {
                          controller.updatePassword(controller.newPassword.value);
                          Get.back();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (controller.isPasswordMatch.value &&
                            controller.newPassword.value.length >= 8)
                        ? sukses
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  child: Text("Simpan", style: inter500(14, white)),
                ),
          )),
        ],
      ),
    ),
  );
}
