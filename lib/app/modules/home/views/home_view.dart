import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../template/color_app.dart';
import '../../beranda/controllers/beranda_controller.dart';
import '../../beranda/views/beranda_view.dart';
import '../../datadiri/controllers/datadiri_controller.dart';
import '../../datadiri/views/datadiri_view.dart';
import '../../konfirmasi_warga/controllers/konfirmasi_warga_controller.dart';
import '../../konfirmasi_warga/views/konfirmasi_warga_view.dart';
import '../../riwayat/controllers/riwayat_controller.dart';
import '../../riwayat/views/riwayat_view.dart';
import '../../rtrw/controllers/rtrw_controller.dart';
import '../../rtrw/views/rtrw_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  BerandaController bController = Get.put(BerandaController());
  RiwayatController rController = Get.put(RiwayatController());
  RtrwController twController = Get.put(RtrwController());
  DatadiriController dController = Get.put(DatadiriController());
  KonfirmasiWargaController kController = Get.put(KonfirmasiWargaController());
  List<Widget> _pages = [
    BerandaView(),
    RiwayatView(),
    RtrwView(),
    KonfirmasiWargaView(),
    DatadiriView(),
  ];

  List<BottomNavigationBarItem> x = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return RefreshIndicator(
          color: biru,
          backgroundColor: white,
          displacement: 40.0,
          onRefresh: () async {
            await bController.fetchWeatherData();
            await controller.getUser(); 
            
          },
          child: IndexedStack(
            index: controller.selectedIndex.value,
            children: _pages,
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        if (controller.userData['jabatan'] == 'Ketua RT' ||
            controller.userData['jabatan'] == 'Ketua RW') {
          _pages = [
            BerandaView(),
            RiwayatView(),
            RtrwView(),
            KonfirmasiWargaView(),
            DatadiriView(),
          ];
          x = [
            _buildBottomNavItem('Beranda', controller.selectedIndex.value == 0, 'assets/nav-fill/beranda.png', 'assets/nav-outlined/beranda.png'),
            _buildBottomNavItem('Riwayat', controller.selectedIndex.value == 1, 'assets/nav-fill/history.png', 'assets/nav-outlined/history.png'),
            _buildBottomNavItem('RT/RW', controller.selectedIndex.value == 2, 'assets/nav-fill/rtrw.png', 'assets/nav-outlined/rtrw.png'),
            _buildBottomNavItem('Cek Warga', controller.selectedIndex.value == 3,'assets/nav-fill/check_warga.png','assets/nav-outlined/check_warga.png'),
            _buildBottomNavItem('Data Diri', controller.selectedIndex.value == 4, 'assets/nav-fill/profil.png', 'assets/nav-outlined/profil.png'),
          ];
          controller.indexPage.value = [0,1,2,3,4];
        }
        else {
          _pages = [
            BerandaView(),
            RiwayatView(),
            RtrwView(),
            DatadiriView(),
          ];
          x = [
            _buildBottomNavItem('Beranda', controller.selectedIndex.value == 0, 'assets/nav-fill/beranda.png', 'assets/nav-outlined/beranda.png'),
            _buildBottomNavItem('Riwayat', controller.selectedIndex.value == 1, 'assets/nav-fill/history.png', 'assets/nav-outlined/history.png'),
            _buildBottomNavItem('RT/RW', controller.selectedIndex.value == 2, 'assets/nav-fill/rtrw.png', 'assets/nav-outlined/rtrw.png'),
            _buildBottomNavItem('Data Diri', controller.selectedIndex.value == 3, 'assets/nav-fill/profil.png', 'assets/nav-outlined/profil.png'),
          ];
          controller.indexPage.value = [0,1,2,3];
        }
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primary1,
          unselectedItemColor: black,
          backgroundColor: primary3,
          showUnselectedLabels: true,
          items: x,
        );
      }),
    );
  }

  // Fungsi untuk membuat item navigasi bawah dengan ikon dan label
  BottomNavigationBarItem _buildBottomNavItem(String label, bool isSelected,
      String selectedIcon, String unselectedIcon) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        isSelected ? selectedIcon : unselectedIcon,
        color: isSelected ? primary1 : black,
        width: 24.w,
        height: 24.h,
      ),
      label: label,
    );
  }
}
