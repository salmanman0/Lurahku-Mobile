import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lurahku_remake/app/modules/beranda/views/dialog.dart';
import 'package:lurahku_remake/app/modules/home/controllers/home_controller.dart';

import '../../../template/color_app.dart';
import '../../../template/font_app.dart';
import '../../../template/jenis_surat.dart';
import '../controllers/beranda_controller.dart';

class BerandaView extends GetView<BerandaController> {
  BerandaView({super.key});
  final HomeController hController = Get.find<HomeController>();
  @override
  final BerandaController controller = Get.put(BerandaController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(()=>Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        hController.selectedIndex.value = hController.indexPage.length - 1;
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("${hController.domainUrl}/${hController.userData['poto_profil']}"),
                        backgroundColor: abudebu,
                        radius: 24.r,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hController.userData['noKK']??"Nomor KK", style: montserrat600(16, black)),
                        Text('${hController.userData['jabatan']} - RT ${hController.userData['rt']} RW ${hController.userData['rw']}',
                            style: montserrat500(12, abudebu)),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: (){showLogoutDialog(context, controller);},
                    icon: const Icon(Icons.exit_to_app_rounded, size: 24)),
              ],
            ),
          ),
          backgroundColor: white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Bagian Atas
              Container(
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Banner Upload KK
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 8.h),
                      padding: EdgeInsets.only(left: 36.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(-100.r)),
                        gradient: LinearGradient(
                          colors: [primary1, primary2],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 36.h, bottom: 16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:MediaQuery.of(context).size.width * 0.5,
                                  margin: EdgeInsets.only(bottom: 24.h),
                                  child: Text(
                                      'Jangan lupa untuk selalu memperbarui data diri kamu apabila ada perubahan ya',
                                      style: montserrat600(14, white)),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    hController.selectedIndex.value = hController.indexPage.length - 1;
                                  },
                                  child: Text(
                                    'Upload KK',
                                    style: montserrat600(12, primary1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 103.w,
                            height: 132.h,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/bg-box.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Banner Upload KK
                  ],
                ),
              ),
              // Bagian Atas
        
              // Prediksi cuaca
              Obx(()=> controller.isLoading.value
                  ? Center(child: CircularProgressIndicator( color: black))
                  :Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 32.h),
                    decoration: BoxDecoration(
                      color: white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Perkiraan cuaca hari ini',
                                style: inter500(14, black)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Text(
                                controller.weatherData['conditionText']?? "TIdak terkoneksi jaringan",
                                style: inter700(24, Colors.blue[900]),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.history, size: 20, color: abudebu),
                                SizedBox(width: 4.w),
                                Text(
                                  controller.weatherData['localtime'] ?? "TIdak terkoneksi jaringan",
                                  style: inter500(12, abupekat),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${controller.weatherData['name']??"Cuaca hari ini"}, ${controller.weatherData['region']??"Pekanbaru"}',
                              style: inter500(14, black),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            controller.wheater.value ?
                            Image.network(
                              'https:${controller.weatherData['conditionIcon']}',
                              width: 52.w,
                            ) :
                            Image.asset(
                              'assets/cuaca.png',
                              width: 52.w,
                            ),
                            Text(
                              '${controller.weatherData['temperature']??0.0}°C',
                              style: inter500(14, black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Prediksi cuaca
        
              // Bagian Pengurusan Surat
              SizedBox(height: 8.h),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(24.r),
                color: white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pengurusan Surat',
                        style: montserrat600(16, black)),
                    SizedBox(height: 24.r),
                    JenisSurat(
                        dialogInputan: ()=> showSuketKematianDialog(context, controller),
                        gambar: 'kematian.png',
                        text1: 'Surat Keterangan',
                        text2: 'Kematian',
                        keterangan: 'Surat Kematian berguna untuk mengurus pencatatan kematian seseorang yang berfungsi sebagai bukti kematian yang sah dan diakui oleh hukum.'),
                    JenisSurat(
                        dialogInputan: ()=> showSuketPenghasilanDialog(context, controller),
                        gambar: 'penghasilan.png',
                        text1: 'Surat Keterangan',
                        text2: 'Penghasilan',
                        keterangan: 'Surat Penghasilan berguna untuk memaparkan informasi resmi mengenai jumlah penghasilan dan data diri seseorang.'),
                    JenisSurat(
                        dialogInputan: ()=> showSuketTidakMampuDialog(context, controller),
                        gambar: 'tidakmampu.png',
                        text1: 'Surat Keterangan',
                        text2: 'Tidak Mampu',
                        keterangan: 'Surat Keterangan Tidak mampu merupakan surat resmi yang dikeluarkan pemerintah untuk menyatakan bahwa seseorang atau keluarga dalam kondisi ekonomi yang tidak mampu.'),
                    JenisSurat(
                        dialogInputan: ()=> showSuketGaibDialog(context, controller),
                        gambar: 'gaib.png',
                        text1: 'Surat Keterangan',
                        text2: 'Gaib',
                        keterangan: 'Surat Keterangan Gaib merupakan surat resmi yang dikeluarkan pemerintah untuk menyatakan bahwa terlapor telah hilang tanpa diketahui.'),
                    JenisSurat(
                        dialogInputan: ()=>showSuketOrangYangSamaDialog(context, controller),
                        gambar: 'orangyangsama.png',
                        text1: 'Surat Keterangan',
                        text2: 'Orang Yang Sama',
                        keterangan: 'Surat ini digunakan untuk menyatakan bahwa dua identitas atau dokumen yang berbeda merujuk pada orang yang sama.'),
                    // JenisSurat(
                    //     dialogInputan: ()=> showSuketDomisiliDialog(context, controller),
                    //     gambar: 'domisili.png',
                    //     text1: 'Surat Keterangan',
                    //     text2: 'Domisili',
                    //     keterangan: 'Tes aja'),
                    JenisSurat(
                        dialogInputan: ()=> showSuketDomisiliPerusahaanDialog(context, controller),
                        gambar: 'domisiliperusahaan.png',
                        text1: 'Surat Keterangan',
                        text2: 'Domisili Perusahaan',
                        keterangan: 'Surat ini digunakan untuk menyatakan alamat resmi sebuah perusahaan. Biasanya diperlukan untuk keperluan administrasi seperti izin usaha, perpajakan, atau pendirian perusahaan.'),
                    JenisSurat(
                        dialogInputan: ()=> showSuketDomisiliUsahaDialog(context, controller),
                        gambar: 'domisiliusaha.png',
                        text1: 'Surat Keterangan',
                        text2: 'Domisili Usaha',
                        keterangan: 'Surat ini mirip dengan domisili perusahaan tetapi lebih spesifik untuk usaha kecil atau perorangan, digunakan untuk keperluan izin usaha dan dokumen administratif lainnya.'),
                    JenisSurat(
                        dialogInputan: ()=> showSuketTanggunganDialog(context, controller),
                        gambar: 'tanggungankeluarga.png',
                        text1: 'Surat Keterangan',
                        text2: 'Tanggungan Keluarga',
                        keterangan: 'Surat ini berisi pernyataan jumlah anggota keluarga yang menjadi tanggungan seseorang. Sering digunakan untuk keperluan administratif seperti beasiswa atau bantuan sosial.'),
                    JenisSurat(
                        dialogInputan: ()=>showSuketPindahWilayahDialog(context, controller),
                        gambar: 'pindahwilayah.png',
                        text1: 'Surat Keterangan',
                        text2: 'Pindah Wilayah',
                        keterangan: 'Surat ini diperlukan saat seseorang pindah dari satu wilayah administrasi ke wilayah lain. Berguna untuk mengurus data kependudukan dan dokumen resmi lainnya.'),
                    // JenisSurat(
                    //     dialogInputan: (){},
                    //     gambar: 'keterangan.png',
                    //     text1: 'Surat',
                    //     text2: 'Keterangan',
                    //     keterangan: 'Tes aja'),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

