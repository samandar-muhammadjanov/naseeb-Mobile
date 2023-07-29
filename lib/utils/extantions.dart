import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:naseeb/domain/repositories/employer_repo/employer_repo.dart';

Future pickImage() async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return;
  final imageTemporary = File(image.path);
  EmployerRepo().uploadPhotoForPost(imageTemporary);
  return imageTemporary;
}
