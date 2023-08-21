import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class HitlistController extends GetxController {
  RxBool isClicked = false.obs;
  RxBool isComplete = false.obs;
  RxString decumentPath = '_'.obs;
  RxList<File> pickedFile = RxList<File>([]);
  RxList<String> pickedFileUrls = RxList<String>([]);
  Rx<List<String>> pickedFileExtension = Rx<List<String>>([]);
  final firebaseStorage = FirebaseStorage.instance;

  Future picDocuments() async {
    try {
      await Permission.photos.request();

      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        pickedFile(result.files.map((e) {
          return File(e.path!);
        }).toList());
      } else {
        log("User canceled the picker");
      }
    } catch (e) {
      kerrorSnackbar(message: e.toString());
    }
  }

  Future uplodDecoments() async {
    int _name = DateTime.now().microsecondsSinceEpoch;
    try {
      for (var e in pickedFile) {
        Reference ref = firebaseStorage
            .ref()
            .child('documents/$_name.${e.path.split('.').last}');
        UploadTask uploadTask = ref.putFile(File(e.path));
        var onComplete = await uploadTask.whenComplete(() => null);
        pickedFileUrls.add(await onComplete.ref.getDownloadURL());
      }
    } catch (e) {
      kerrorSnackbar(message: e.toString());
    }
  }

  Future onUserCompleteTask({
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? snapshot,
    int? index,
  }) async {
    isClicked(true);
    final name = GetStorage().read('name');
    try {
      await uplodDecoments();
      await DB.tasks.doc(snapshot!.data!.docs[index!].id).update({
        "documents": FieldValue.arrayUnion(pickedFileUrls),
        "submitted_by": name,
        "submitted_at": FieldValue.serverTimestamp(),
        'status': "processing",
      });
      pickedFile.clear();
      pickedFileUrls.clear();
      isClicked(false);
      Get.back();
      ksucessSnackbar(message: "Assignment Submited SuccesFully");
    } catch (e) {
      isClicked(false);
      kerrorSnackbar(message: e.toString());
    } finally {
      isClicked(false);
    }
  }
}
