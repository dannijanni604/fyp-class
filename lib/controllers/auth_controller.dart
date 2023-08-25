import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/views/student_view/student_tabs_view.dart';
import 'package:first_platoon/views/teacher_view/teacher_home_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  QueryDocumentSnapshot<Map<String, dynamic>>? userSnaposhots;
  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  RxBool onLogin = false.obs;
  // student
  final userCodecontroller = TextEditingController();
  // teacher
  final adminNameController = TextEditingController();
  final adminFatherNameController = TextEditingController();
  final adminEmailController = TextEditingController();
  final adminPasswordController = TextEditingController();
  final groupIdController = TextEditingController();

  // student var

  String? currentUserId = '';
  String? currentUserCode = '';
  String? currentUSerName = '';

  GetStorage storage = GetStorage();

  Future login(BuildContext context) async {
    onLogin(true);
    try {
      await auth
          .signInWithEmailAndPassword(
              email: adminEmailController.text,
              password: adminPasswordController.text)
          .then((value) {
        onLogin(false);
        adminNameController.clear();
        adminFatherNameController.clear();
        adminEmailController.clear();
        adminPasswordController.clear();
        Get.off(() => const TeacherHomeView());
      });
    } on FirebaseAuthException catch (e) {
      onLogin(false);
      return kerrorSnackbar(message: e.toString());
    }
  }

  Future signOut(BuildContext context) async {
    await auth.signOut();
  }

  Future signUp(BuildContext context) async {
    try {
      onLogin(true);
      if (groupIdController.text.isNotEmpty) {
        var doc = await DB.groups.doc(groupIdController.text).get();
        if (!doc.exists) {
          kerrorSnackbar(message: "Group not exists");
          onLogin(false);
          return;
        }
      }
      var credential = await auth.createUserWithEmailAndPassword(
        email: adminEmailController.text,
        password: adminPasswordController.text,
      );
      final uid = credential.user!.uid;
      await DB.admins.doc(uid).set({
        "name": adminNameController.text,
        "email": adminEmailController.text,
        "uid": uid,
        "group_id":
            groupIdController.text.isEmpty ? "" : groupIdController.text,
      });
      if (groupIdController.text.isNotEmpty) {
        await DB.groups.doc(groupIdController.text).update({
          'admin_ids': FieldValue.arrayUnion([uid]),
        });
      } else {
        await DB.groups.doc().set({
          'admin_ids': FieldValue.arrayUnion([uid]),
        });
        var docs = await DB.groups.where('admin_ids', arrayContains: uid).get();
        if (docs.docs.isNotEmpty) {
          await DB.admins.doc(uid).update({'group_id': docs.docs.first.id});
        }
      }
      onLogin(false);
      adminNameController.clear();
      adminEmailController.clear();
      Get.offAll(() => const TeacherHomeView());
    } on FirebaseAuthException catch (e) {
      onLogin(false);
      return kerrorSnackbar(message: e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      onLogin(true);
      await auth.sendPasswordResetEmail(email: email);
      kerrorSnackbar(
        message: "Reset password email sent, Please check your mail",
      );
      onLogin(false);
    } on FirebaseAuthException catch (e) {
      onLogin(true);
      return kerrorSnackbar(message: e.toString());
    }
  }

  Future loginAsUser(BuildContext context) async {
    try {
      onLogin(true);
      bool isUserExist = await DB.members
          .where('code', isEqualTo: userCodecontroller.text)
          .get()
          .then<bool>((value) async {
        for (var e in value.docs) {
          currentUSerName = e.data()['name'];
          currentUserCode = e.data()['code'];
          currentUserId = e.id;
          userCodecontroller.clear();
          storage.write("id", currentUserId);
          storage.write("code", currentUserCode);
          storage.write("name", currentUSerName);
        }
        try {
          await auth.signInAnonymously();
          log("User Sign In Anonymously");
          userCodecontroller.clear();
        } on FirebaseAuthException catch (e) {
          switch (e.code) {
            case "operation-not-allowed":
              break;
            default:
            // kerrorSnackbar(message: e.toString());
          }
        }

        if (value.docs.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      });

      if (isUserExist) {
        onLogin(false);
        return appNavReplace(context, StudentTabView());
      } else {
        onLogin(false);
        return kerrorSnackbar(message: "User Did't Match Try Another Code");
      }
    } on Exception catch (e) {
      onLogin(false);
      return kerrorSnackbar(message: e.toString());
    }
  }
}
