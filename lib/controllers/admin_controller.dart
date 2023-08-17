import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/models/admin.dart';
import 'package:first_platoon/views/auth_views/auth_options_view.dart';
import 'package:get/get.dart';

class AdminController extends GetxController with StateMixin {
  late Admin admin;

  static AdminController to = Get.find<AdminController>();

  @override
  void onReady() {
    super.onReady();
    checkAuth();
  }

  Future checkAuth() async {
    try {
      var doc =
          await DB.admins.doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (doc.exists) {
        admin = Admin.fromJson(doc.data() ?? {});
        change(admin, status: RxStatus.success());
      } else {
        kerrorSnackbar(message: "You are not authorized");
        await FirebaseAuth.instance.signOut();
        Get.offAll(() => const AuthOptionsView());
      }
    } catch (e) {
      change(admin, status: RxStatus.error(e.toString()));
    }
  }
}
