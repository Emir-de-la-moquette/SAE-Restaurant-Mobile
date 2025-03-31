import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerResto extends StatefulWidget {
  const ImagePickerResto({super.key});

  @override
  State<ImagePickerResto> createState() => _ImagePickerRestoState();
}

class _ImagePickerRestoState extends State<ImagePickerResto> {
  List<Uint8List> _imageBytesList = [];

  Future<void> _captureImageFromCamera() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final Uint8List bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytesList.add(bytes);
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytesList.add(bytes);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageBytesList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sélection d'images")),
      body: _imageBytesList.isEmpty
          ? const Center(child: Text('Aucune image enregistrée'))
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Nombre de colonnes
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: _imageBytesList.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.memory(_imageBytesList[index], fit: BoxFit.cover),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () => _removeImage(index),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 12,
                    child: Icon(Icons.close, size: 15, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _pickImageFromGallery,
            child: const Icon(Icons.photo_library),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _captureImageFromCamera,
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
