import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../template/color_app.dart';
import '../../../../template/font_app.dart';
import '../../../home/controllers/home_controller.dart';
import '../../controllers/datadiri_controller.dart';

void showKonfirmasiModal(BuildContext context) {
  final DatadiriController controller = Get.put(DatadiriController());
  final HomeController hController = Get.put(HomeController());

  Get.defaultDialog(
    title: "Konfirmasi RT",
    titleStyle: inter700(16, black),
    content: Obx(()=> Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w),
        child: 
        controller.checkRekom.value? 
        Center(
          child: Text("Anda Telah Meminta Rekomendasi RT", style: montserrat500(14, sukses.withRed(50)), textAlign: TextAlign.center,),
        ) :
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dropdown RW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RW', style: montserrat600(14, black)),
                Obx(() {
                  return SizedBox(
                    width: 180,
                    child: DropdownButton<String>(
                      value: controller.selectedRW.value.isNotEmpty
                          ? controller.selectedRW.value
                          : null,
                      hint: Text('Pilih RW', style: inter500(14, abupekat),),
                      items: controller.rwList.map((rwMap) {
                        return DropdownMenuItem<String>(
                          value: rwMap['rw'], // Akses 'rw' dari map
                          child: Text(rwMap['rw'], style: montserrat600(14, black),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.setRW(value);
                          // Update RT List berdasarkan RW yang dipilih
                          controller.setRT(''); // Reset RT saat RW berubah
                        }
                      },
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 16.h),
            // Dropdown RT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RT', style: montserrat600(14, black)),
                Obx(() {
                  var rtList = controller.rwList.firstWhere(
                      (element) => element['rw'] == controller.selectedRW.value,
                      orElse: () => {'jumlah_rt': []})['jumlah_rt'];
      
                  return SizedBox(
                    width: 180,
                    child: DropdownButton<String>(
                      value: controller.selectedRT.value.isNotEmpty
                          ? controller.selectedRT.value
                          : null,
                      hint: Text('Pilih RT', style: inter500(14, abupekat)),
                      items: rtList.map<DropdownMenuItem<String>>((String rt) {
                        return DropdownMenuItem<String>(
                          value: rt,
                          child: Text(rt, style: montserrat600(14, black),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.setRT(value);
                        }
                      },
                    ),
                  );
                }),
              ],
            ),
            SizedBox(height: 24.h),
            // Tombol Simpan
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  controller.postRekom(hController.userData['uId'], controller.selectedRT.value, controller.selectedRW.value);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text('Simpan',style: TextStyle(fontSize: 14, color: white)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
