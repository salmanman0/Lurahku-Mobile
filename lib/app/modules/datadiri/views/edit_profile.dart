import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lurahku_remake/app/template/kolom_inputan.dart';

import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/editprofil_controller.dart';

class EditProfileDialog extends StatelessWidget {
  final HomeController hController = Get.find<HomeController>();
  final EditProfileDialogController controller =
      Get.put(EditProfileDialogController());

  EditProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah Profil", style: montserrat600(16, black)),
        backgroundColor: white,
      ),
      body: WillPopScope(
        onWillPop: () async {
          controller.selectedImage.value = "";
          controller.noKKController.text = hController.userData['noKK'];
          controller.emailController.text = hController.userData['email'];
          controller.noHpController.text = hController.userData['noHp'];
          controller.alamatController.text = hController.userData['alamat'];
          return true;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 16.h, left: 16.h, right: 16.h, bottom: 32.h),
          color: white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: controller.pickImage, // Fungsi untuk mengambil gambar
                      child: Obx(() {
                        return CircleAvatar(
                          radius: 50.r,
                          backgroundImage: controller.selectedImage.value != ""
                              ? FileImage(File(controller.selectedImage.value))
                              : NetworkImage(
                                  "${hController.domainUrl}/${hController.userData['poto_profil']}"),
                          backgroundColor: abupekat,
                          child: controller.selectedImage.value == ""
                              ? Icon(Icons.camera_alt,
                                  color: Colors.grey.shade800, size: 30.r)
                              : null,
                        );
                      }),
                    ),
                    SizedBox(height: 16.h),
                    KolomInputan(label: "Nomor Kartu Keluarga", labelStyle: inter400(16, abupekat), textEditingC: controller.noKKController, isPassword: false, isNumber: true),
                    SizedBox(height: 16.h),
                    KolomInputan(label: "Email", labelStyle: inter400(16, abupekat), textEditingC: controller.emailController, isPassword: false, isNumber: false),
                    SizedBox(height: 16.h),
                    KolomInputan(label: "Nomor HP", labelStyle: inter400(16, abupekat), textEditingC: controller.noHpController, isPassword: false, isNumber: true),
                    SizedBox(height: 16.h),
                    KolomInputan(label: "Alamat", labelStyle: inter400(16, abupekat), textEditingC: controller.alamatController, isPassword: false, isNumber: false),
                  ],
                ),
                SizedBox(height: 270.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      final selectedImage = controller.selectedImage.value.isNotEmpty? controller.selectedImage.value:null;
                      controller.updateProfil(selectedImage);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: sukses,
                      padding:EdgeInsets.symmetric(horizontal: 50.w, vertical: 14.h),
                    ),
                    child: Obx(()=> controller.isLoading.value? CircularProgressIndicator(color: white) : Text("Simpan", style: inter500(16, white))),
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
