import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rtrw_controller.dart';

class RtrwView extends GetView<RtrwController> {
  const RtrwView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RtrwView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RtrwView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
