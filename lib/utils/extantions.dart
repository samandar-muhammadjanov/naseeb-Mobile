import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future pickImage() async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return;
  final imageTemporary = File(image.path);
  return imageTemporary;
}
