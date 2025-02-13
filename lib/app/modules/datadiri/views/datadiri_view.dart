import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/datadiri_controller.dart';

class DatadiriView extends GetView<DatadiriController> {
  const DatadiriView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DatadiriView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DatadiriView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
