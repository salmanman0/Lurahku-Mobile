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

  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Obx(
          () => controller.checkRekom.value
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: sukses, size: 48),
                    SizedBox(height: 12.h),
                    Text(
                      "Anda Telah Meminta Rekomendasi RT",
                      style: montserrat600(14, sukses.withRed(50)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text("Tutup", style: montserrat600(14, white)),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Konfirmasi Domisili Anda", style: inter700(18, black)),
                    SizedBox(height: 16.h),

                    // Dropdown RW
                    Text("RW", style: montserrat600(14, black)),
                    SizedBox(height: 6.h),
                    Obx(() {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade100,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: controller.selectedRW.value.isNotEmpty
                                ? controller.selectedRW.value
                                : null,
                            hint: Text('Pilih RW', style: inter500(14, abupekat)),
                            items: controller.rwList.map((rwMap) {
                              return DropdownMenuItem<String>(
                                value: rwMap['rw'],
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on, color: primary1, size: 18),
                                    SizedBox(width: 8),
                                    Text(rwMap['rw'], style: montserrat600(14, black)),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.setRW(value);
                                controller.setRT('');
                              }
                            },
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 16.h),

                    // Dropdown RT
                    Text("RT", style: montserrat600(14, black)),
                    SizedBox(height: 6.h),
                    Obx(() {
                      var rtList = controller.rwList.firstWhere(
                        (element) => element['rw'] == controller.selectedRW.value,
                        orElse: () => {'jumlah_rt': []},
                      )['jumlah_rt'];

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade100,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: controller.selectedRT.value.isNotEmpty
                                ? controller.selectedRT.value
                                : null,
                            hint: Text('Pilih RT', style: inter500(14, abupekat)),
                            items: rtList.map<DropdownMenuItem<String>>((String rt) {
                              return DropdownMenuItem<String>(
                                value: rt,
                                child: Row(
                                  children: [
                                    Icon(Icons.home, color: primary1, size: 18),
                                    SizedBox(width: 8),
                                    Text(rt, style: montserrat600(14, black)),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.setRT(value);
                              }
                            },
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 24.h),

                    // Tombol Simpan
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.postRekom(
                              hController.userData['uId'],
                              controller.selectedRT.value,
                              controller.selectedRW.value);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          elevation: 4,
                        ),
                        child: Text('Simpan', style: montserrat600(14, white)),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    ),
  );
}
