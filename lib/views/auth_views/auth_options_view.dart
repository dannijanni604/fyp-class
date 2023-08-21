import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/auth_views/teacher_login_view.dart';
import 'package:first_platoon/views/auth_views/student_login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthOptionsView extends StatelessWidget {
  const AuthOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final ctrl = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.size.height * 0.1,
              horizontal: Get.size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/class_guide.png"),
              Text(
                "CLASS GUIDE",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
              ),
              SizedBox(height: Get.size.height * 0.07),
              SizedBox(
                width: Get.size.width / 1.05,
                child: kAppButton(
                  onPressed: () {
                    appNavPush(context, const TeacherLogin());
                  },
                  padding: const EdgeInsets.only(
                      left: 30, top: 2, bottom: 2, right: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Login as Teacher",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      kAppButton(
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
              const Text("- - - - - Or - - - - -"),
              SizedBox(height: Get.size.height / 20),
              SizedBox(
                width: Get.size.width / 1.05,
                child: kAppButton(
                  onPressed: () {
                    appNavPush(
                      context,
                      const StudentLoginView(),
                    );
                  },
                  padding: const EdgeInsets.only(
                      left: 30, top: 2, bottom: 2, right: 2),
                  color: AppTheme.kblueColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Login as Student",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      kAppButton(
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
