import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/controllers/admin_controller.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCompaignsConteroller extends GetxController with StateMixin {
  @override
  void onInit() {
    change(null, status: RxStatus.success());
    searchMember("", true);
    super.onInit();
  }

  RxBool indicator = false.obs;
  RxList<Map<String, dynamic>> members = RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> scheduleMembers =
      RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> taskMembers = RxList<Map<String, dynamic>>([]);
  final authId = FirebaseAuth.instance.currentUser!.uid;

// Quiz
  final scheduleTaskController = TextEditingController();
  final scheduledateController = TextEditingController();
  DateTimeRange? scheduledDateTime;
  final scheduleMemberController = TextEditingController();
  final scheduleformkey = GlobalKey<FormState>();

  // Assignment
  final taskTaskController = TextEditingController();
  final taskdueDateController = TextEditingController();
  final taskMemberController = TextEditingController();
  final _taskformkey = GlobalKey<FormState>();
  get taskformkey => _taskformkey;

  // Add Member
  final memberNameController = TextEditingController();
  final genetrateCodeController = TextEditingController();
  final _memberformkey = GlobalKey<FormState>();
  get memberformkey => _memberformkey;

// Groups
  final groupMemberController = TextEditingController();
  final groupNameController = TextEditingController();
  String? groupId;

  List<String> adminJoinedGroupsIds = [];

  Future addSchedule() async {
    indicator(true);
    try {
      await DB.schedules.doc().set(
        {
          'doc_id': AdminController.to.admin.groupId,
          'schdule': scheduleTaskController.text,
          'date': scheduledDateTime!.start,
          'end_date': scheduledDateTime!.end,
          'members': FieldValue.arrayUnion(
              scheduleMembers.map((e) => e['id']).toList()),
        },
      );
      ksucessSnackbar(message: "Quiz Added Successfuly");
      scheduleTaskController.clear();
      scheduleMemberController.clear();
      scheduleMembers.clear();
      scheduledateController.clear();
    } on Exception catch (e) {
      kerrorSnackbar(message: e.toString());
      indicator(false);
    } finally {
      indicator(false);
    }
  }

  Future addTask() async {
    if (_taskformkey.currentState!.validate()) {
      if (taskMembers.isNotEmpty) {
        indicator(true);
        try {
          await DB.tasks.doc().set(
            {
              'doc_id': AdminController.to.admin.groupId,
              'task': taskTaskController.text,
              'submitted_by': "",
              'due_date': taskdueDateController.text,
              'created_at': FieldValue.serverTimestamp(),
              'submitted_at': '',
              'members': FieldValue.arrayUnion(
                  taskMembers.map((e) => e['id']).toList()),
              'documents': [],
              'status': null,
            },
          );
          ksucessSnackbar(message: "Assignment Added Successfully");
          taskTaskController.clear();
          taskdueDateController.clear();
          taskMemberController.clear();
          taskMembers.clear();
        } on Exception catch (e) {
          kerrorSnackbar(message: e.toString());
          indicator(false);
        } finally {
          indicator(false);
        }
      } else {
        kerrorSnackbar(message: "Enter Assignment Member List");
      }
    }
  }

  Future addMember() async {
    if (_memberformkey.currentState!.validate()) {
      indicator(true);
      try {
        bool isCodeExist = await DB.members
            .where('code', isEqualTo: genetrateCodeController.text)
            .get()
            .then<bool>((value) {
          if (value.docs.isNotEmpty) {
            return true;
          }
          return false;
        });
        if (isCodeExist) {
          return kerrorSnackbar(
              message: "User is already exist try another code");
        } else {
          DB.members.doc().set(
            {
              'name': memberNameController.text.toLowerCase(),
              'name_search_terms': getSearchTerms(memberNameController.text),
              'code': genetrateCodeController.text,
              'created_at': DateTime.now(),
              'auth_id': AdminController.to.admin.groupId,
            },
          );
          memberNameController.clear();
          genetrateCodeController.clear();
          searchMember("", true);
          ksucessSnackbar(message: "Code Generated Successfuly");
        }
      } on Exception catch (e) {
        indicator(false);
        kerrorSnackbar(message: e.toString());
      } finally {
        indicator(false);
      }
    }
  }

  Timer? timeHandle;
  Future searchMember(String text, [bool loaddAll = false]) async {
    try {
      if (loaddAll == false) {
        if (timeHandle != null) {
          timeHandle?.cancel();
        }
      }
      timeHandle = Timer(const Duration(milliseconds: 700), () async {
        members.clear();
        change(members, status: RxStatus.loading());
        late QuerySnapshot<Map<String, dynamic>> doc;
        if (loaddAll || text.isEmpty) {
          doc = await DB.members
              .where('auth_id', isEqualTo: AdminController.to.admin.groupId)
              .get();
        } else {
          doc = await DB.members
              .where('auth_id', isEqualTo: AdminController.to.admin.groupId)
              .where('name_search_terms', arrayContains: text)
              .get();
        }
        if (doc.docs.isNotEmpty) {
          for (var element in doc.docs) {
            members.add({
              'name': element.data()['name'],
              'id': element.id,
            });
          }
        }
        final set = <String>{};
        members.retainWhere((e) => set.add(e['id']));
        change(members, status: RxStatus.success());
      });
    } catch (e) {
      change(members, status: RxStatus.error(e.toString()));
    }
  }

  List<String> getSearchTerms(String string) {
    List<String> searchList = [];
    String temp = "";
    for (int i = 0; i < string.length; i++) {
      temp = temp + string[i];
      searchList.add(temp.toLowerCase());
    }
    return searchList;
  }
}
