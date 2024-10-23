import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class SaveImage {
  static Future<String> saveImageToGallery(XFile file) async {
    await ImageGallerySaver.saveFile(file.path);
    return "OK";
  }
}
