import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lurahku_remake/app/template/color_app.dart';

class ImageWithRotation extends StatelessWidget {
  final String imageUrl;
  final File? imageFile;

  const ImageWithRotation({super.key, required this.imageUrl, this.imageFile});

  // Fungsi untuk menentukan apakah gambar dalam mode landscape
  Future<bool> _isLandscape(String imageUrl) async {
    final image = NetworkImage(imageUrl);
    final completer = Completer<ImageInfo>();
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info);
      }),
    );
    final imageInfo = await completer.future;
    return imageInfo.image.width > imageInfo.image.height;
  }

  @override
  Widget build(BuildContext context) {
    // Jika file gambar dipilih dari galeri atau kamera, tampilkan gambar file tersebut
    if (imageFile != null) {
      return AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: abudebu),
          ),
          child: Image.file(
            imageFile!,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    // Jika tidak ada file, tampilkan gambar dari URL atau placeholder jika URL tidak tersedia
    final imageUrlToDisplay = imageUrl.isNotEmpty
        ? imageUrl
        : 'http://192.168.1.5:5000/static/image/default-kk.jpg';

    return FutureBuilder<bool>(
      future: _isLandscape(imageUrlToDisplay),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final isLandscape = snapshot.data!;
        return AspectRatio(
          aspectRatio: 3 / 4,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Transform.rotate(
              angle: isLandscape ? 3.14 / 2 : 0, // Rotate 90° jika lanskap
              child: Image.network(
                imageUrlToDisplay,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Tampilkan placeholder jika gambar gagal dimuat
                  return const Icon(Icons.error, size: 50, color: Colors.red);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
