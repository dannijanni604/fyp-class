import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatController extends GetxController {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth get auth => _auth;
  FirebaseFirestore get fireStore => _firestore;
  String currentUserID = '';

  @override
  void onReady() {
    currentUserID = currentUseId();
    super.onReady();
  }

  String currentUseId() {
    final studentID = GetStorage().read("id");
    if (studentID != null) {
      printError(info: 'is Student login : $studentID');
      return studentID;
    } else {
      printError(info: _auth.currentUser!.uid);
      return _auth.currentUser!.uid;
    }
  }
}
