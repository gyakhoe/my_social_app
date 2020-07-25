import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageRepository {
  Future<File> selectImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 10);
    return pickedFile == null ? null : File(pickedFile.path);
  }
}
