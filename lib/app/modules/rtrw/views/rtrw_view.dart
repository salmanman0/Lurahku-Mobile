import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../../../template/list_ketua.dart';
import '../controllers/rtrw_controller.dart';
import '../../home/controllers/home_controller.dart';

class RtrwView extends GetView<RtrwController> {
  RtrwView({super.key});
  final RtrwController controller = Get.put(RtrwController());
  final HomeController hController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ketua RT & RW', style: montserrat600(16, black)),
          backgroundColor: white,
        ),
        body: Column(
          children: [
            // Display RT/RW information box
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 12.h, left: 20.w, right: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 36.h),
              decoration: BoxDecoration(
                color: primary3,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RichText(
                      text: TextSpan(
                        text: 'Kamu berada di ',
                        style: montserrat500(16, black),
                        children: [
                          TextSpan(
                            text: 'RT ${hController.userData['rt']} RW ${hController.userData['rw']}',
                            style: montserrat700(16, Colors.green[800]),
                          ),
                          TextSpan(
                            text: '. Ayo cari tau ketua RT & RW kamu!',
                            style: montserrat500(16, black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Image.asset('assets/bg-rtrw.png', fit: BoxFit.cover),
                  ),
                ],
              ),
            ),

            // Search Box
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: Obx(() {
                return TextField(
                  controller: controller.searchController,
                  onChanged: (value) => controller.updateSearchQuery(value),
                  decoration: InputDecoration(
                    hintText: 'Cari disini...',
                    hintStyle: montserrat500(14, abupekat),
                    suffixIcon: controller.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.close, size: 28.r, color: abupekat),
                            onPressed: () {
                              controller.searchController.clear();
                              controller.updateSearchQuery('');  // Clear search query in the controller
                            },
                          )
                        : Icon(Icons.search, size: 28.r, color: abupekat),
                    border: const OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 20.h),
                  ),
                );
              }),
            ),

            // TabBar
            TabBar(
              labelColor: primary1,
              unselectedLabelColor: abupekat,
              indicatorColor: primary1,
              tabs: const [
                Tab(text: "Semua"),
                Tab(text: "RW"),
                Tab(text: "RT"),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  Obx(() {
                    final filteredKetua = controller.filteredKetua;
                    return RefreshIndicator(
                      color: biru,
                      backgroundColor: white,
                      onRefresh: () async {
                        controller.fetchKetuaData();
                      },
                      child: filteredKetua.isEmpty
                          ? SingleChildScrollView(physics: const AlwaysScrollableScrollPhysics(),  child: SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height*0.4, child: Center(child: Text("Data tidak ditemukan", style: montserrat600(14, black)))))
                          : ListView.builder(
                              itemCount: filteredKetua.length,
                              itemBuilder: (context, index) {
                                final ketua = filteredKetua[index];
                                return ListKetua(
                                  gambar: "${hController.domainUrl}/${ketua.gambar}",
                                  nama: ketua.nama,
                                  jabatan: ketua.jabatan,
                                  rt: ketua.rt,
                                  rw: ketua.rw,
                                  alamat: ketua.alamat,
                                  noHp: ketua.noHp,
                                );
                              },
                            ),
                    );
                  }),

                  // "RW" Tab
                  Obx(() {
                    final rwKetua = controller.filteredKetua.where((ketua) => ketua.jabatan == 'Ketua RW').toList();
                    return RefreshIndicator(
                      color: biru,
                      backgroundColor: white,
                      onRefresh: () async {
                        controller.fetchKetuaData();
                      },
                      child: rwKetua.isEmpty
                          ? SingleChildScrollView(physics: const AlwaysScrollableScrollPhysics(),  child: SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height*0.4, child: Center(child: Text("Data tidak ditemukan", style: montserrat600(14, black)))))
                          : ListView.builder(
                              itemCount: rwKetua.length,
                              itemBuilder: (context, index) {
                                final ketua = rwKetua[index];
                                return ListKetua(
                                  gambar: "${hController.domainUrl}/${ketua.gambar}",
                                  nama: ketua.nama,
                                  jabatan: ketua.jabatan,
                                  rt: ketua.rt,
                                  rw: ketua.rw,
                                  alamat: ketua.alamat,
                                  noHp: ketua.noHp,
                                );
                              },
                            ),
                    );
                  }),

                  // "RT" Tab
                  Obx(() {
                    final rtKetua = controller.filteredKetua.where((ketua) => ketua.jabatan == 'Ketua RT').toList();
                    return RefreshIndicator(
                      color: biru,
                      backgroundColor: white,
                      onRefresh: () async {
                        controller.fetchKetuaData();
                      },
                      child: rtKetua.isEmpty
                          ? SingleChildScrollView(physics: const AlwaysScrollableScrollPhysics(),  child: SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height*0.4, child: Center(child: Text("Data tidak ditemukan", style: montserrat600(14, black)))))
                          : ListView.builder(
                              itemCount: rtKetua.length,
                              itemBuilder: (context, index) {
                                final ketua = rtKetua[index];
                                return ListKetua(
                                  gambar: "${hController.domainUrl}/${ketua.gambar}",
                                  nama: ketua.nama,
                                  jabatan: ketua.jabatan,
                                  rt: ketua.rt,
                                  rw: ketua.rw,
                                  alamat: ketua.alamat,
                                  noHp: ketua.noHp,
                                );
                              },
                            ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
