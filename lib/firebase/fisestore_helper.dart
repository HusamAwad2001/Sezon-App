import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sezon_app/firebase/storage_helper.dart';
import 'package:sezon_app/models/product_model.dart';
import 'package:sezon_app/models/user_model.dart';

import '../core/storage/storage.dart';
import '../view/widgets/snack.dart';

class FirestoreHelper {
  static final firebaseFirestore = FirebaseFirestore.instance;
  static final instance = FirestoreHelper._internal();

  factory FirestoreHelper() => instance;

  FirestoreHelper._internal();

  /// ----------------------------------------------------------------------------------------------
  /// Store user data in firestore
  Future<bool> setUserData(UserModel userModel) async {
    try {
      bool isExist = await checkUserNameOrPhone(userModel.userName, userModel.phone);
      if (isExist) {
        return false;
      } else {
        await firebaseFirestore.collection('users').doc().set(userModel.toJson());
        return true;
      }
    } catch (e) {
      Snack().show(type: false, message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      print('Error: $e');
      return false;
    }
  }

  /// ----------------------------------------------------------------------------------------------
  /// Check if username or phone is exist
  Future<bool> checkUserNameOrPhone(String userName, String phone) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore.collection('users').where('userName', isEqualTo: userName).get();
      List documents = querySnapshot.docs;
      for (int i = 0; i < documents.length; i++) {
        if (documents[i].data()['userName'] == userName) {
          Snack().show(type: false, message: 'اسم المستخدم موجود مسبقاً');
          return true;
        }
      }

      QuerySnapshot<Map<String, dynamic>> querySnapshot2 =
          await firebaseFirestore.collection('users').where('phone', isEqualTo: phone).get();
      List documents2 = querySnapshot2.docs;
      for (int i = 0; i < documents2.length; i++) {
        if (documents2[i].data()['phone'] == phone) {
          Snack().show(type: false, message: 'رقم الهاتف موجود مسبقاً');
          return true;
        }
      }
    } catch (e) {
      Snack().show(type: false, message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      print('error: $e');
    }
    return false;
  }

  /// ----------------------------------------------------------------------------------------------
  /// Get all users
  Future<bool> getAllUsers({required String phone, required String password}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore.collection('users').where('phone', isEqualTo: phone).get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
      if (documents.isEmpty) {
        Snack().show(type: false, message: 'رقم الهاتف غير صحيح');
        return false;
      }

      if (documents[0].data()['phone'] == phone) {
        if (documents[0].data()['password'] == password) {
          UserModel userModel = UserModel.fromJson(documents[0].data());
          userModel.id = documents[0].id;
          Storage.instance.write('user', userModel.toJson());
          return true;
        } else {
          Snack().show(type: false, message: 'كلمة المرور غير صحيحة');
          return false;
        }
      } else {
        Snack().show(type: false, message: 'رقم الهاتف غير صحيح');
        return false;
      }
    } catch (e) {
      Snack().show(type: false, message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      print('error: $e');
    }
    return false;
  }

  /// ----------------------------------------------------------------------------------------------
  /// Add product
  Future<bool> addProduct(ProductModel productModel, File fileImg) async {
    try {
      ({bool status, String url}) uploaded =
          await StorageHelper.instance.uploadImage('products', fileImg);
      if (uploaded.status) {
        productModel.imageUrl = uploaded.url;
        await firebaseFirestore.collection('products').doc().set(productModel.toJson());
      }
      return true;
    } catch (e) {
      Snack().show(type: false, message: 'حدث خطأ ما يرجى المحاولة مرة أخرى');
      print('Error: $e');
    }
    return false;
  }

  /// ----------------------------------------------------------------------------------------------
  /// Add product
  Future<(List<ProductModel> products, bool status)> getAllProducts(String category) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
      List<ProductModel>? details = documents.map((e) {
        ProductModel productModel = ProductModel.fromJson(e.data());
        productModel.id = e.id;
        return productModel;
      }).toList();
      return (details, true);
    } catch (e) {
      print('error: $e');
      return ([].cast<ProductModel>(), false);
    }
  }
}
