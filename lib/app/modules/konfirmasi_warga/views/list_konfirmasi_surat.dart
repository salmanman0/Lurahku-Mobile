import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lurahku_remake/app/modules/konfirmasi_warga/controllers/konfirmasi_warga_controller.dart';
import 'package:lurahku_remake/app/template/color_app.dart';
import 'package:lurahku_remake/app/template/font_app.dart';

import '../../konfirmasi_warga/views/dialog.dart';

class ListKonfirmasiSurat extends StatelessWidget {
  final Map<String, dynamic> dataSurat;
  final KonfirmasiWargaController controller;

  const ListKonfirmasiSurat({
    super.key,
    required this.dataSurat,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 4.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(color: white, boxShadow: [
        BoxShadow(
          color: black.withOpacity(0.2),
          offset: const Offset(0, 3),
          blurRadius: 2,
          spreadRadius: 2,
        )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 12.h),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dataSurat['jenis_surat'], style: inter500(14, black)),
                    Text(dataSurat['nama_pelapor'], style: inter500(12, abupekat)),
                    SizedBox(height: 8.h),
                    Text(dataSurat['tanggal_pengajuan'], style: inter500(12, abupekat)),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if(dataSurat['jenis_surat'] == "Surat Keterangan Kematian"){
                    showSuketKematianDialog(context, dataSurat);
                  }
                  if(dataSurat['jenis_surat'] == "Surat Keterangan Penghasilan"){
                    showSuketPenghasilanDialog(context, dataSurat);
                  }
                  if(dataSurat['jenis_surat'] == "Surat Keterangan Tidak Mampu"){
                    showSuketTidakMampuDialog(context, dataSurat);
                  }
                  if(dataSurat['jenis_surat'] == "Surat Keterangan Gaib"){
                    showSuketGaibDialog(context, dataSurat);
                  }
                  if(dataSurat['jenis_surat'] == "Surat Keterangan Orang Yang Sama"){
                    showSuketOrangYangSamaDialog(context, dataSurat);
                  }
                  if(dataSurat['jenis_surat'] == "Surat Keterangan Domisili"){
                    showSuketDomisiliDialog(context, dataSurat);
                  }
                  if(dataSurat['jenis_surat'] == "Surat Keterangan Domisili Perusahaan"){
                    showSuketDomisiliPerusahaanDialog(context, dataSurat);
                  }
                  if(dataSurat['jenis_surat'] == "Surat Keterangan Domisili Usaha"){
                    showSuketDomisiliUsahaDialog(context, dataSurat);
                  }
                  if(dataSurat['jenis_surat'] == "Surat Keterangan Tanggungan Keluarga"){
                    showSuketTanggunganDialog(context, dataSurat);
                  }
                  if(dataSurat['jenis_surat'] == "Surat Keterangan Pindah Wilayah"){
                    showSuketPindahWilayahDialog(context, dataSurat);
                  }
                },
                padding: EdgeInsets.zero,
                constraints:const BoxConstraints(),
                icon: Icon(Icons.info_outline, color: biru),
              ),
              IconButton(
                onPressed: () {
                  showRejectDialog(context, dataSurat['suratId']);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.close, color: gagal),
              ),
              IconButton(
                onPressed: () {
                  showAcceptDialog(context, dataSurat['suratId']);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.check, color: sukses),
              ),
            ],
          ),
        ],
      ),
    );
  }

  
}
