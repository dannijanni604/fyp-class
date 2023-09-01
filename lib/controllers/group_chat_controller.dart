import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatController extends GetxController {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth get auth => _auth;
  FirebaseFirestore get fireStore => _firestore;
  String currentUserID = '';
  bool isauth = false;

  RxList<File> pickedDocuments = RxList<File>([]);
  RxList<String> pickedFileUrls = RxList<String>([]);
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  RxBool indicator = RxBool(false);
  final messageController = TextEditingController();

  @override
  void onReady() {
    currentUserID = currentUserId();
    super.onReady();
  }

  String currentUserId() {
    final studentID = GetStorage().read("id");
    if (studentID != null) {
      return studentID;
    } else {
      return _auth.currentUser!.uid;
    }
  }

  Future picDocuments() async {
    try {
      indicator(true);
      await Permission.photos.request();
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        pickedDocuments(result.files.map((e) {
          return File(e.path!);
        }).toList());
        await onUplodDecoments();
      } else {
        log("User canceled the documests");
      }
    } catch (e) {
      indicator(false);
      kerrorSnackbar(message: e.toString());
    }
  }

  Future onUplodDecoments() async {
    int _name = DateTime.now().microsecondsSinceEpoch;
    try {
      for (var e in pickedDocuments) {
        Reference ref = firebaseStorage
            .ref()
            .child('documents/$_name.${e.path.split('.').last}');
        UploadTask uploadTask = ref.putFile(File(e.path));
        var onComplete = await uploadTask.whenComplete(() => null);
        pickedFileUrls.add(await onComplete.ref.getDownloadURL());

        await fireStore.collection("chat").doc().set({
          'uid': currentUserID,
          'message': FieldValue.arrayUnion(pickedFileUrls),
          'type': 'doc',
          'sendAt': FieldValue.serverTimestamp(),
        });
        pickedFileUrls.clear();
        pickedDocuments.clear();
        indicator(false);
      }
    } catch (e) {
      printError(info: e.toString());
      // kerrorSnackbar(message: e.toString());
      indicator(false);
    }
  }
}
