import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lurahku_remake/app/modules/datadiri/views/image_rotation.dart';

import '../../../../template/color_app.dart';
import '../../../../template/font_app.dart';
import '../../../home/controllers/home_controller.dart';
import '../../controllers/datadiri_controller.dart';

void showImageModal(BuildContext context) {
  final HomeController hController = Get.find<HomeController>();
  final DatadiriController controller = Get.find<DatadiriController>(); // gunakan Get.find
  
  // Dialog dengan reset gambar saat keluar
  Get.defaultDialog(
    title: "Upload Kartu Keluarga\nMaksimal ukuran 2mb",
    titleStyle: inter500(20, abupekat),
    content: WillPopScope(
      // Reset gambar saat dialog ditutup
      onWillPop: () async {
        controller.selectedImage.value = ''; // Reset gambar saat keluar dari dialog
        return true; // Izinkan dialog ditutup
      },
      child: Column(
        children: [
          Obx(() {
            return ImageWithRotation(
              imageUrl: hController.userData['gambar_kk'] != null
                  ? "${hController.domainUrl}/${hController.userData['gambar_kk']}"
                  : "https://www.shutterstock.com/image-vector/gorontalo-indonesia-13-februari-2024-260nw-2424885335.jpg",
              imageFile: controller.selectedImage.value.isNotEmpty
                  ? File(controller.selectedImage.value)
                  : null, // File gambar jika dipilih
            );
          }),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () => controller.pickImage(ImageSource.camera),
                icon: Icon(Icons.camera_alt, color: primary1),
                label: Text('Kamera', style: montserrat600(12, black)),
              ),
              ElevatedButton.icon(
                onPressed: () => controller.pickImage(ImageSource.gallery),
                icon: Icon(Icons.photo_library, color: primary1),
                label: Text('Galeri', style: montserrat600(12, black)),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                controller.updateGambarKK(controller.selectedImage.value);
                controller.selectedImage.value = ''; 
                Get.back(); // Tutup dialog
              },
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(sukses)),
              child: Text('Simpan', style: montserrat600(14, white)),
            ),
          ),
        ],
      ),
    ),
  );
}
