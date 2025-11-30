import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<String?> pickImageAsBase64() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file == null) return null;

    final bytes = await File(file.path).readAsBytes();
    return base64Encode(bytes);
  }
}
