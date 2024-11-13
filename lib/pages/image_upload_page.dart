import 'package:CSEN268_F24/services/save_image/save_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({super.key});

  @override
  State<ImageUploadPage> createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;
  XFile? _xfile;
  DocumentReference? _docRef;
  String? _storagePath;
  String? _downloadUrl;
  double _progress = 0;
  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      bucket: "gs://fir-messaging-8b691.firebasestorage.app");

  @override
  void initState() {
    super.initState();
  }

  void addUser() async {
    _docRef = await FirebaseFirestore.instance
        .collection('users_test')
        .add({'name': 'John Doe', 'email': 'john@doe.com'});
    setState(() {});
  }

  void progressCallback(double value) {
    setState(() {
      _progress = value;
    });
  }

  void pickImage() async {
    _xfile = await _picker.pickImage(source: ImageSource.gallery);
    _imagePath = _xfile?.path;
    setState(() {});
  }

  void uploadImage() async {
    if (_docRef != null && _imagePath != null) {
      String imageName =
          "${p.basenameWithoutExtension(_imagePath!)}_${DateTime.now().microsecondsSinceEpoch}.${p.extension(_imagePath!)}";
      _storagePath = "users/${_docRef?.id}/images/$imageName";

      setState(() {});
      _downloadUrl = await SaveImage.uploadImageToStorage(
        file: _xfile!,
        storageReference: storage.ref(_storagePath),
        updateCallback: progressCallback,
      );

      await _docRef
          ?.collection('images')
          .add({'imageUrl': _downloadUrl, 'imagePath': _storagePath});
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Upload to Storage"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add a User to get ref", style: tt.labelMedium),
              Text("UserId: ${_docRef?.id} \nPath: ${_docRef?.path}"),
              FilledButton(
                  child: Text("Add User"),
                  onPressed: _docRef == null
                      ? () {
                          addUser();
                        }
                      : null),
              Divider(),
              Text("Image Path", style: tt.labelMedium),
              Text(
                "$_imagePath",
                maxLines: 2,
              ),
              FilledButton(
                  child: Text("Get Image"),
                  onPressed: _imagePath == null
                      ? () {
                          pickImage();
                        }
                      : null),
              Divider(),
              Text("Storage Path", style: tt.labelMedium),
              Text(
                "$_storagePath",
                maxLines: 2,
              ),
              FilledButton(
                child: Text("Upload"),
                onPressed: _downloadUrl == null
                    ? () {
                        uploadImage();
                      }
                    : null,
              ),
              Text("Progress Indicator", style: tt.labelMedium),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 10),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 10,
                ),
              ),
              Divider(),
              Text("Download Url", style: tt.labelMedium),
              Text(
                "$_downloadUrl",
                maxLines: 2,
              ),
              if (_downloadUrl != null)
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                    child: Image.network(_downloadUrl!)),
            ],
          ),
        )));
  }
}
