import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static final firestore = FirebaseFirestore.instance;
  static final instance = FirestoreHelper._internal();

  factory FirestoreHelper() => instance;

  FirestoreHelper._internal();
}
