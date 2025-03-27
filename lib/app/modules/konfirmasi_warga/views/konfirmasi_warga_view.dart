import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../controllers/konfirmasi_warga_controller.dart';
import '../../home/controllers/home_controller.dart';
import 'list_konfirmasi_surat.dart';
import 'list_konfirmasi_warga.dart';

class KonfirmasiWargaView extends StatelessWidget {
  final KonfirmasiWargaController controller = Get.put(KonfirmasiWargaController());
  final HomeController hController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: max(1, _getTabs().length), // Menghindari length = 0
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cek Warga', style: montserrat600(16, black)),
          backgroundColor: white,
          bottom: TabBar(
            labelColor: primary1,
            unselectedLabelColor: abupekat,
            indicatorColor: primary1,
            tabs: _getTabs(),
          ),
        ),
        body: TabBarView(
          children: _getTabBodies(),
        ),
      ),
    );
  }

  // Fungsi untuk mendapatkan daftar tab
  List<Widget> _getTabs() {
    if (hController.userData['jabatan'] == 'Ketua RT') {
      return const [
        Tab(text: 'Konfirmasi Warga'),
        Tab(text: 'Konfirmasi Surat'),
      ];
    } else if (hController.userData['jabatan'] == 'Ketua RW') {
      return const [
        Tab(text: 'Konfirmasi Surat'),
      ];
    }
    // Tambahkan default tab jika jabatan tidak valid
    return [const Tab(text: 'Tidak Ada Akses')];
  }

  // Fungsi untuk mendapatkan isi setiap tab
  List<Widget> _getTabBodies() {
    if (hController.userData['jabatan'] == 'Ketua RT') {
      return [
        _buildKonfirmasiWargaTab(),
        _buildKonfirmasiSuratTab(),
      ];
    } else if (hController.userData['jabatan'] == 'Ketua RW') {
      return [
        _buildKonfirmasiSuratTab(),
      ];
    }
    // Tampilan default jika user tidak memiliki akses
    return [const Center(child: Text('Akses tidak valid'))];
  }

  // Tab untuk Konfirmasi Warga
  Widget _buildKonfirmasiWargaTab() {
    return RefreshIndicator(
      backgroundColor: white,
      color: biru,
      onRefresh: () async {
        await controller.getSurat();
        await controller.getRekom();
      },
      child: Obx(() {
        if (controller.wargaRekom.isEmpty) {
          return _buildEmptyState('Tidak ada permintaan warga');
        }
        return ListView.builder(
          itemCount: controller.wargaRekom.length,
          itemBuilder: (context, index) {
            final warga = controller.wargaRekom[controller.wargaRekom.length - 1 - index];
            return ListKonfirmasiWarga(
              gambar: "${hController.domainUrl}/${warga['poto_profil']}",
              nama: warga['nama'] ?? 'Nama tidak tersedia',
              noKK: warga['noKK'] ?? '-',
              nik: warga['nik'],
              alamat: warga['alamat'],
              noHp: warga['noHp'],
              gambarKK: "${hController.domainUrl}/${warga['gambar_kk']}",
              rekomId: warga['rekomId'],
              controller: controller,
            );
          },
        );
      }),
    );
  }

  // Tab untuk Konfirmasi Surat
  Widget _buildKonfirmasiSuratTab() {
    return RefreshIndicator(
      backgroundColor: white,
      color: biru,
      onRefresh: () async {
        await controller.getSurat();
        await controller.getRekom();
      },
      child: Obx(() {
        var suratFiltered = controller.suratRekom.where((surat) {
          if (hController.userData['jabatan'] == "Ketua RT") {
            return surat['status_surat'] == "Menunggu Persetujuan RT" &&
                surat['rt'] == hController.userData['rt'] &&
                surat['rw'] == hController.userData['rw'];
          } else if (hController.userData['jabatan'] == "Ketua RW") {
            return surat['status_surat'] == "Menunggu Persetujuan RW" &&
                surat['rt'] == hController.userData['rt'] &&
                surat['rw'] == hController.userData['rw'];
          }
          return false;
        }).toList();

        if (suratFiltered.isEmpty) {
          return _buildEmptyState('Tidak ada permintaan surat');
        }

        return ListView.builder(
          itemCount: suratFiltered.length,
          itemBuilder: (context, index) {
            final surat = suratFiltered[suratFiltered.length - 1 - index];
            return ListKonfirmasiSurat(
              dataSurat: surat,
              controller: controller,
            );
          },
        );
      }),
    );
  }

  // Widget untuk menampilkan status kosong
  Widget _buildEmptyState(String message) {
    return RefreshIndicator(
      backgroundColor: white,
      color: biru,
      onRefresh: () async {
        await controller.getSurat();
        await controller.getRekom();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(Get.context!).size.height * 0.75,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                message,
                style: montserrat600(14, black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
