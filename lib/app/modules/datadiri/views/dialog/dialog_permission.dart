import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lurahku_remake/app/modules/datadiri/controllers/datadiri_controller.dart';
import 'package:lurahku_remake/app/template/color_app.dart';
import 'package:lurahku_remake/app/template/font_app.dart';

void showPermissionDialog(BuildContext context) {
  final DatadiriController controller = Get.put(DatadiriController());
  RxBool isChecked = false.obs;

  Get.defaultDialog(
    title: "Peringatan Perizinan!",
    titleStyle: inter700(22, black),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pesan perizinan
        Text(
          "Untuk meningkatkan pengalaman Anda, aplikasi ini membutuhkan izin untuk mengumpulkan dan memproses data tertentu, termasuk informasi akun, lokasi, dan aktivitas aplikasi. Data ini akan digunakan sesuai dengan kebijakan privasi kami dan tidak akan disebarkan tanpa persetujuan Anda.",
          textAlign: TextAlign.justify,
          style: inter500(16, black),
        ),
        SizedBox(height: 12.h),

        Text(
          "Dengan menyetujui, Anda memberikan izin kepada aplikasi ini untuk menggunakan data tersebut guna memberikan layanan yang lebih baik dan sesuai dengan kebutuhan Anda.",
          textAlign: TextAlign.justify,
          style: inter500(16, black),
        ),
        SizedBox(height: 16.h),

        // Checkbox dengan teks persetujuan
        Obx(() => Row(
              children: [
                Checkbox(
                  value: isChecked.value,
                  onChanged: (value) => isChecked.value = value!,
                  activeColor: sukses,
                ),
                Expanded(
                  child: Text(
                    "Saya menyetujui pengumpulan data pribadi.",
                    style: inter500(16, black),
                  ),
                ),
              ],
            )),
        SizedBox(height: 16.h),

        // Tombol "Setuju" dan "Tolak"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Obx(() => ElevatedButton(
                    onPressed: isChecked.value ? () {
                      controller.updatePermission(true);
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isChecked.value ? sukses : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    child: Text("Setuju", style: montserrat500(16, white)),
                  )),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  controller.updatePermission(false);
                } ,
                style: ElevatedButton.styleFrom(
                  backgroundColor: gagal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                ),
                child: Text("Tolak", style: montserrat500(16, white)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
