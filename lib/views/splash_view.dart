import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/admin_view/admin_home_tabs.dart';
import 'package:first_platoon/views/user_view/user_tabs_view.dart';
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
        Get.off(() => const UserHomeView());
      } else if (FirebaseAuth.instance.currentUser != null) {
        return Get.off(() => const AdminHomeView());
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
          children: [
            Text(
              "MANAGEMENT \n APP",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: AppTheme.kprimaryColor,
                  ),
            ),
            SizedBox(height: Get.size.height * 0.05),
            // Image.asset(
            //   "assets/images/platoon.png",
            //   scale: 2,
            // ),
          ],
        ),
      ),
    );
  }
}
