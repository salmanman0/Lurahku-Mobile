import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/datadiri_controller.dart';
import 'dialog/dialog_konfirmasi_rtrw.dart';

class DatadiriView extends GetView<DatadiriController> {
  DatadiriView({super.key});
  final HomeController hController = Get.find<HomeController>();
  @override
  final DatadiriController controller = Get.put(DatadiriController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: DiagonalClipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.55,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bg-profil.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.33,
                  left: 20.w,
                  right: 20.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () { },
                              borderRadius: BorderRadius.circular(50.r),
                              child: Container(
                                width: 120.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  color: backgroundScreen,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage("${hController.domainUrl}/${hController.userData['poto_profil']}"),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: backgroundScreen, width: 5),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: primary1.withOpacity(0.5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      hController.getUser();
                                      controller.getKeluarga();
                                      controller.getRekomPersonal();
                                      hController.selectedIndex.value = 0;
                                      hController.selectedIndex.value = hController.indexPage.length-1;
                                    },
                                    tooltip: "Perbarui Halaman",
                                    icon: Icon(
                                      Icons.restart_alt_outlined,
                                      color: black,
                                      size: 24.r,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    tooltip: "Ubah Profil",
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: black,
                                      size: 24.r,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(hController.userData['noKK'] ?? "Nomor KK", style: montserrat600(16, black)),
                      Text('${hController.userData['jabatan']} - RT ${hController.userData['rt']} RW ${hController.userData['rw']}', style: montserrat500(14, black)),
                    ],
                  ),
                ),
              ],
            ),
            Obx(()=> hController.isLoading.value? SizedBox(child: Center(child: CircularProgressIndicator(color: biru),),): const SizedBox.shrink()),
            InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60.h,
                margin: EdgeInsets.only(top: 8.h),
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [white, primary1], stops: const [0.9, 1]),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Upload Kartu Keluarga',
                  style: montserrat600(14, black),
                ),
              ),
            ),
            InkWell(
              onTap: (){},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60.h,
                margin: EdgeInsets.only(top: 8.h),
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [white, primary1], stops: const [0.9, 1]),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Tambah Anggota Keluarga',
                  style: montserrat600(14, black),
                ),
              ),
            ),
            InkWell(
              onTap: (){ 
                if (controller.keluarga.isEmpty) {
                  Get.dialog(
                    Center(
                      child: Material(
                        color: Colors.transparent, // Pastikan tidak ada background
                        child: Text(
                          "Upload Kartu Keluarga dan Tambahkan Anggota Keluarga",
                          style: inter500(16, white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    barrierDismissible: false,
                  );
                  Future.delayed(const Duration(seconds: 2), () {
                    // hController.getUser();
                    Get.back(); 
                  });
                }
                else{
                  showKonfirmasiModal(context); 
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60.h,
                margin: EdgeInsets.only(top: 8.h),
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [white, primary1], stops: const [0.9, 1]),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Meminta Konfirmasi RT',
                  style: montserrat600(14, black),
                ),
              ),
            ),
            InkWell(
              onTap: (){},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60.h,
                margin: EdgeInsets.only(top: 8.h),
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [white, primary1], stops: const [0.9, 1]),
                  borderRadius: BorderRadius.all(Radius.circular(10.r),),
                ),
                child: Text(
                  'Ubah Password',
                  style: montserrat600(14, black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 100); // Bottom left corner
    path.lineTo(size.width, size.height - 200); // Diagonal to the right side
    path.lineTo(size.width, 0.0); // Top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

