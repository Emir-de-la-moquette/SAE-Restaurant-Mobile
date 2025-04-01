import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerResto extends StatefulWidget {
  final int osmId;

  const ImagePickerResto({super.key, required this.osmId});

  @override
  State<ImagePickerResto> createState() => _ImagePickerRestoState();
}

class _ImagePickerRestoState extends State<ImagePickerResto> {
  List<Uint8List> _imageBytesList = [];

  @override
  void initState(){
    super.initState();
    _initializeImages();
  }

  Future<void> _initializeImages() async {
    List<String> imagePaths = ['assets/image1.png', 'assets/image2.png','assets/image3.png',];//A remplacer par la requete à la BD locale

    List<Uint8List> imageList = [];

    for (String path in imagePaths) {
      final ByteData imageData = await rootBundle.load(path);
      final Uint8List bytes = imageData.buffer.asUint8List();
      imageList.add(bytes);
    }

    setState(() {
      _imageBytesList = imageList;
    });
  }

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
      // puis pop de la BD
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sélection d'images"),centerTitle: true,),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _imageBytesList.isEmpty
              ? const Center(child: Text('Aucune image enregistrée'))
              : SizedBox(
            height: 150, // Hauteur de la liste d'images
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_imageBytesList.length, (index) {
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: MemoryImage(_imageBytesList[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 10,
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
                }),
              ),
            ),
          ),
        ],
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
