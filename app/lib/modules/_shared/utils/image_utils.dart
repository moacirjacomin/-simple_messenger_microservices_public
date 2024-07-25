import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageUtils {
  static Image imageFromBase64String(
    String base64String, {
    ImageErrorWidgetBuilder? errorBuilder,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.memory(base64Decode(base64String), errorBuilder: errorBuilder, fit: fit);
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64FromImageFile(File file) {
    final imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }
}
