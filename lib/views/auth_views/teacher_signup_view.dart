import 'package:first_platoon/controllers/auth_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/components/qr_scanner_view.dart';
import 'package:first_platoon/core/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherSignUpView extends StatelessWidget {
  const TeacherSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final ctrl = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register As Teacher"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: Get.size.height * 0.03),
                Text("Welcome To Class Guide", style: Const.labelText()),
                SizedBox(height: Get.size.height * 0.03),
                const Text("Sign Up With Email And Password"),
                SizedBox(height: Get.size.height * 0.03),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name"),
                      SizedBox(height: Get.size.height * 0.01),
                      TextFormField(
                        controller: ctrl.adminNameController,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please Enter Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: Get.size.height * 0.03),
                      const Text("Email"),
                      SizedBox(height: Get.size.height * 0.01),
                      TextFormField(
                        controller: ctrl.adminEmailController,
                        validator: (val) {
                          return Const.validateEmail(val!);
                        },
                      ),
                      SizedBox(height: Get.size.height * 0.03),
                      const Text("Password"),
                      SizedBox(height: Get.size.height * 0.01),
                      TextFormField(
                        controller: ctrl.adminPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          errorMaxLines: 2,
                        ),
                        validator: (val) {
                          return Const.validateCode(val!);
                        },
                      ),
                      SizedBox(height: Get.size.height * 0.03),
                      const Text("Group ID (Optional)"),
                      SizedBox(height: Get.size.height * 0.01),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () async {
                              String? data = await Get.to(
                                () => const QRScannerView(),
                              );
                              if (data != null) {
                                ctrl.groupIdController.text = data;
                              }
                            },
                            icon: const Icon(Icons.qr_code),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.size.height * 0.08),
                      Center(
                        child: Obx(() {
                          return ctrl.onLogin.value
                              ? const CircularProgressIndicator()
                              : kAppButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ctrl.signUp(context);
                                    }
                                  },
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 50,
                                  ),
                                  label: "Sign Up",
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
