import 'package:first_platoon/controllers/auth_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentLoginView extends StatelessWidget {
  const StudentLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final ctrl = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login As Student"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // IconButton(
                //   onPressed: () {
                //     Get.back();
                //   },
                //   icon: const Icon(
                //     Icons.arrow_back_ios_new,
                //     size: 25,
                //   ),
                // ),
                SizedBox(height: Get.size.height * 0.03),
                Text("Welcome To Class Guide", style: Const.labelText()),
                SizedBox(height: Get.size.height * 0.03),
                const Text("Login By Code That Provide Your Teacher"),
                SizedBox(height: Get.size.height * 0.03),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.size.height * 0.03),
                      const Text("Enter Code"),
                      SizedBox(height: Get.size.height * 0.01),
                      TextFormField(
                        controller: ctrl.userCodecontroller,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter Code To Login";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: Get.size.height * 0.08),
                      Obx(() {
                        return Center(
                          child: ctrl.onLogin.value
                              ? const CircularProgressIndicator()
                              : kAppButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ctrl.loginAsUser(context);
                                    }
                                  },
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 50),
                                  label: "Login",
                                ),
                        );
                      }),
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
