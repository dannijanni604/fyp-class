import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_platoon/core/db.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController with StateMixin {
  @override
  void onInit() async {
    super.onInit();
  }

  RxBool isClicked = false.obs;

  Future findCurrentUserId() async {}
}
