import 'package:file_saver/file_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class SaveImage {
  static Future<String> saveImageToGallery(XFile file) async {
    var bytes = await file.readAsBytes();
    await FileSaver.instance.saveFile(
        name: "Hello", bytes: bytes, ext: "jpg", mimeType: MimeType.jpeg);
    return "OK";
  }

  static Future<String?> uploadImageToStorage(
      {required XFile file,
      required Reference storageReference,
      void Function(double)? updateCallback}) async {
    return null;
  }
}
