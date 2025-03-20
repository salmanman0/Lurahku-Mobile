import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lurahku_remake/app/modules/datadiri/controllers/datadiri_controller.dart';
import 'package:lurahku_remake/app/template/color_app.dart';
import 'package:lurahku_remake/app/template/font_app.dart';

void showUbahPasswordDialog(BuildContext context) {
  final DatadiriController controller = Get.put(DatadiriController());

  Get.defaultDialog(
    title: "Ubah Password",
    titleStyle: montserrat600(16, black),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Obx(() => TextField(
            obscureText: controller.lihat1.value, 
            decoration: InputDecoration(
              labelText: "Password Baru",
              labelStyle: inter400(14, abupekat),
              errorText: controller.newPassword.value.isNotEmpty && !controller.isPasswordMatch.value
                  ? null
                  : null,
              filled: true,
              fillColor: Colors.grey[200],
              suffixIcon: IconButton(onPressed: controller.isPeek1, icon: controller.lihat1.value? Icon(Icons.visibility_off) : Icon(Icons.visibility) )
            ),
            onChanged: (value) {
              controller.newPassword.value = value;
              controller.checkPasswordMatch();
            },
            
          )),
          const SizedBox(height: 12),
          Obx(() => TextField(
            obscureText: controller.lihat2.value,
            decoration: InputDecoration(
              labelText: "Ulangi Password Baru",
              labelStyle: inter400(14, abupekat),
              errorText: controller.confirmPassword.value.isNotEmpty && !controller.isPasswordMatch.value
                  ? "Password tidak cocok"
                  : null,
              filled: true,
              fillColor: Colors.grey[200],
              suffixIcon: IconButton(onPressed: controller.isPeek2, icon: controller.lihat2.value? Icon(Icons.visibility_off) : Icon(Icons.visibility) )

            ),
            onChanged: (value) {
              controller.confirmPassword.value = value;
              controller.checkPasswordMatch();
            },
          )),
          const SizedBox(height: 12),
          Obx(() => controller.isPasswordMatch.value
              ? Text(
                  "Password cocok",
                  style: inter500(12, sukses),
                )
              : const SizedBox.shrink()),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (controller.isPasswordMatch.value) {
                if(controller.newPassword.value.length > 8){
                  controller.updatePassword(controller.newPassword.value);
                  Get.back();
                }
                else{
                  Get.snackbar("Gagal", "Minimal memiliki 8 karater", backgroundColor: gagal.withOpacity(0.8), colorText: white);
                }
              }
            },
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(sukses)
            ),
            child: Text("Simpan", style: montserrat500(16, white),),
          ),
        ],
      ),
    ),
  );
}
