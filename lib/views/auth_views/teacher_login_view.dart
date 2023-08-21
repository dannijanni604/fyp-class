import 'package:first_platoon/controllers/auth_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/views/auth_views/teacher_forget_password_view.dart';
import 'package:first_platoon/views/auth_views/teacher_signup_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherLogin extends StatelessWidget {
  const TeacherLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final ctrl = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login As Teacher"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // IconButton(
                //   onPressed: () {
                //     appNavReplace(context, AuthOptionsView());
                //   },
                //   icon: const Icon(
                //     Icons.arrow_back_ios_new,
                //     size: 25,
                //   ),
                // ),
                SizedBox(height: Get.size.height * 0.03),
                Text("Welcome To Class Guide", style: Const.labelText()),
                SizedBox(height: Get.size.height * 0.03),
                const Text("Login With Email And Password"),
                SizedBox(height: Get.size.height * 0.03),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Enter Email"),
                      SizedBox(height: Get.size.height * 0.01),
                      TextFormField(
                        controller: ctrl.adminEmailController,
                        validator: (val) {
                          return Const.validateEmail(val!);
                        },
                      ),
                      SizedBox(height: Get.size.height * 0.03),
                      const Text("Enter Pasword"),
                      SizedBox(height: Get.size.height * 0.01),
                      TextFormField(
                        controller: ctrl.adminPasswordController,
                        obscureText: true,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter Code To Login";
                          } else {
                            return null;
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              appNavPush(
                                  context, const TeacherForgetPasswordView());
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              appNavPush(context, const TeacherSignUpView());
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.size.height * 0.08),
                      Center(
                        child: Obx(() {
                          return ctrl.onLogin.value
                              ? const CircularProgressIndicator()
                              : kAppButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ctrl.login(context);
                                    }
                                  },
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 50),
                                  label: "Login",
                                );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
