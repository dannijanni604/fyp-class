import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/views/teacher_view/teacher_home_tabs.dart';
import 'package:first_platoon/views/student_view/student_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'auth_views/auth_options_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      final user = GetStorage().read('code');
      if (user != null) {
        Get.off(() => const StudenthHomeView());
      } else if (FirebaseAuth.instance.currentUser != null) {
        return Get.off(() => const TeacherHomeView());
      } else {
        Get.off(() => const AuthOptionsView());
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/images/class_guide.png")],
        ),
      ),
    );
  }
}
