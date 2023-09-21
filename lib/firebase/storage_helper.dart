import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  StorageHelper._();
  static final instance = StorageHelper._();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<({String url, bool status})> uploadImage(String folderName, File file) async {
    try {
      String fileName = file.path.split('/').last;
      Reference reference = firebaseStorage.ref('$folderName/$fileName');
      TaskSnapshot taskSnapshot = await reference.putFile(file);
      String imageUrl = await reference.getDownloadURL();
      return (url: imageUrl, status: true);
    } catch (e) {
      print(e.toString());
      return (url: '', status: false);
    }
  }
}
