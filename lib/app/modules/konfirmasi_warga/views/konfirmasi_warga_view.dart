import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/konfirmasi_warga_controller.dart';

class KonfirmasiWargaView extends GetView<KonfirmasiWargaController> {
  const KonfirmasiWargaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KonfirmasiWargaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KonfirmasiWargaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
