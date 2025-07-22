import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? selectedImage;

  Future<void> pickImage() async {
    if (await Permission.storage.request().isGranted) {
      final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (returnedImage == null) return;

      setState(() {
        selectedImage = File(returnedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: selectedImage == null
            ? Center(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Icon(Icons.image, color: Colors.grey, size: 40),
                    SizedBox(height: 20),
                    Text('upload image'),
                  ],
                ),
              )
            : Image.file(selectedImage!, fit: BoxFit.cover),
      ),
    );
  }
}
