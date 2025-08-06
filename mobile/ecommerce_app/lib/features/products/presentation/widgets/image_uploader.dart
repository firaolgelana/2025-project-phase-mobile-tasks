import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader extends StatefulWidget {
  final void Function(String) onImageSelected;
  const ImageUploader({super.key, required this.onImageSelected});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  XFile? selectedImage;

  Future<void> pickImage() async {
    if (!kIsWeb) {
      return;
    }

    final returnedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (returnedImage == null) return;

    setState(() {
      selectedImage = returnedImage;
    });

    widget.onImageSelected(returnedImage.path);
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
            ? const Center(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Icon(Icons.image, color: Colors.grey, size: 40),
                    SizedBox(height: 20),
                    Text('upload image'),
                  ],
                ),
              )
            : kIsWeb
            ? Image.network(selectedImage!.path, fit: BoxFit.cover)
            : Image.file(File(selectedImage!.path), fit: BoxFit.cover),
      ),
    );
  }
}
