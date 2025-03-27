import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lurahku_remake/app/template/color_app.dart';
import 'package:lurahku_remake/app/template/font_app.dart';

class RiwayatSurat extends StatelessWidget {
  final String surat;
  final String tanggal;
  final String status;
  final String keterangan;

  RiwayatSurat({
    super.key,
    required this.surat,
    required this.tanggal,
    required this.status,
    this.keterangan = '',
  });

  // Getter untuk menentukan warna status
  Color get warnastatus {
    switch (status) {
      case 'Surat Disetujui':
        return sukses;
      case 'Ditolak RT':
      case 'Ditolak RW':
        return gagal;
      case 'Menunggu Persetujuan RT':
        return proses;
      case 'Menunggu Persetujuan RW':
        return proses2;
      case 'Menunggu Persetujuan Lurah':
        return proses3;
      default:
        return Colors.white;
    }
  }

  // Getter untuk menentukan gambar status
  String get gambar {
    switch (status) {
      case 'Surat Disetujui':
        return 'sukses.png';
      case 'Ditolak RT':
      case 'Ditolak RW':
        return 'gagal.png';
      case 'Menunggu Persetujuan RT':
      case 'Menunggu Persetujuan RW':
      case 'Menunggu Persetujuan Lurah':
        return 'info.png';
      default:
        return '';
    }
  }

  // Getter untuk menampilkan catatan jika ada
  Widget get addKeterangan {
    if (keterangan.isNotEmpty) {
      String jabatan = "";
      if (status.contains("Ditolak RT") || status.contains("Menunggu Persetujuan RW")) {
        jabatan = "RT";
      } else if (status.contains("Ditolak RW") || status.contains("Menunggu Persetujuan Lurah")) {
        jabatan = "RW";
      }

      return SizedBox(
        width: 0.6 * MediaQueryData.fromView(WidgetsBinding.instance.window).size.width,
        child: Text(
          'Catatan $jabatan: $keterangan',
          style: montserrat500(12, abupekat),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [white, warnastatus],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.75, 1],
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(surat, style: montserrat600(16, black)),
                Text(tanggal, style: montserrat500(12, abupekat)),
                SizedBox(height: 12.h),
                Text(
                  status == "Surat Disetujui" ? "Silahkan dijemput di kelurahan" : status,
                  style: montserrat500(12, warnastatus),
                ),
                addKeterangan,
              ],
            ),
          ),
          Image.asset(
            'assets/$gambar',
            scale: 5.r,
          ),
        ],
      ),
    );
  }
}
