import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DisplayImage {
  static Widget displayImage(XFile file) {
    return Image.file(File(file.path));
  }
}
