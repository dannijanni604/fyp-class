import 'package:first_platoon/controllers/auth_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/auth_views/admin_login_view.dart';
import 'package:first_platoon/views/auth_views/user_login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthOptionsView extends StatelessWidget {
  const AuthOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.size.height * 0.1,
              horizontal: Get.size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Management App",
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
              ),
              SizedBox(height: Get.size.height * 0.05),
              // Image.asset(
              //   'assets/images/platoon.png',
              //   scale: 2.5,
              // ),
              SizedBox(height: Get.size.height * 0.1),
              SizedBox(
                width: Get.size.width / 1.05,
                child: kAppButton(
                  padding: const EdgeInsets.only(
                      left: 30, top: 2, bottom: 2, right: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Login as Admin",
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      kAppButton(
                        onPressed: () {
                          appNavPush(context, const AdminLoginView());
                        },
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        color: AppTheme.kblueColor,
                        child: const Icon(
                          Icons.arrow_right_alt_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.size.height / 20),
              Text("- - - - - Or - - - - -"),
              SizedBox(height: Get.size.height / 20),
              SizedBox(
                width: Get.size.width / 1.05,
                child: kAppButton(
                  padding:
                      EdgeInsets.only(left: 30, top: 2, bottom: 2, right: 2),
                  color: AppTheme.kblueColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Login as User",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      kAppButton(
                        onPressed: () {
                          appNavPush(
                            context,
                            const UserLoginView(),
                          );
                        },
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: const Icon(
                          Icons.arrow_right_alt_rounded,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
