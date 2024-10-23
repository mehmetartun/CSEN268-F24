import 'package:CSEN268_F24/services/display_image/display_image.dart';
import 'package:CSEN268_F24/services/save_image/save_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Example"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () async {
                _image = await _picker.pickImage(source: ImageSource.camera);
                print(_image?.path);

                if (_image != null) {
                  await SaveImage.saveImageToGallery(_image!);
                  setState(() {});
                }
              },
              child: Text("Pick Image"),
            ),
            if (_image != null) DisplayImage.displayImage(_image!),
          ],
        ),
      ),
    );
  }
}
