import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../template/color_app.dart';
import '../../../../template/font_app.dart';
import '../../../home/controllers/home_controller.dart';
import '../../controllers/datadiri_controller.dart';

void showUnggahKK(BuildContext context) {
  final HomeController hController = Get.find<HomeController>();
  final DatadiriController controller = Get.find<DatadiriController>();

  Get.defaultDialog(
    backgroundColor: white,
    title: "Upload Kartu Keluarga *Maks 2 MB",
    titleStyle: inter500(18, abupekat),
    content: WillPopScope(
      onWillPop: () async {
        controller.selectedImage.value = ''; 
        return true;
      },
      child: Column(
        children: [
          // Area tampilan gambar besar
          GestureDetector(
            onTap: () => showImagePickerBottomSheet(context, controller),
            child: Obx(() {
              bool isDefaultImage = controller.selectedImage.value.isEmpty && "${hController.domainUrl}/${hController.userData['gambar_kk']}" == "${hController.domainUrl}/";
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8, 
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: isDefaultImage
                          ? Image.network(
                              "${hController.domainUrl}/static/image/default-kk.jpg",
                              fit: BoxFit.cover,
                            )
                          : InteractiveViewer(
                              maxScale: 4.0,
                              minScale: 1.0,
                              child: controller.selectedImage.value.isNotEmpty
                                  ? Image.file(
                                      File(controller.selectedImage.value),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      "${hController.domainUrl}/${hController.userData['gambar_kk']}",
                                      fit: BoxFit.cover,
                                    ),
                            ),
                    ),
                  ),
                  // Ikon tambah jika gambar masih default
                  if (isDefaultImage)
                    Positioned(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.7), // Warna abu-abu transparan
                        ),
                        child: Icon(Icons.add, size: 40, color: white),
                      ),
                    ),
                ],
              );
            }),
          ),
          SizedBox(height: 16.h),

          // Tombol Simpan
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ElevatedButton(
              onPressed: () {
                controller.updateGambarKK(controller.selectedImage.value);
                controller.selectedImage.value = ''; 
                Get.back(); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: sukses,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Simpan', style: montserrat600(14, white)),
            ),
          ),
        ],
      ),
    ),
  );
}

// Bottom Sheet untuk memilih sumber gambar
void showImagePickerBottomSheet(BuildContext context, DatadiriController controller) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Pilih Sumber Gambar", style: montserrat600(16, black)),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.camera_alt, color: primary1),
              title: Text('Ambil dari Kamera', style: inter500(14, black)),
              onTap: () {
                controller.pickImage(ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: primary1),
              title: Text('Pilih dari Galeri', style: inter500(14, black)),
              onTap: () {
                controller.pickImage(ImageSource.gallery);
                Get.back();
              },
            ),
          ],
        ),
      );
    },
  );
}
