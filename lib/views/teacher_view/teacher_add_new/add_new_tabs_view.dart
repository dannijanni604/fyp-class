import 'package:first_platoon/views/teacher_view/teacher_add_new/add_student_view.dart';
import 'package:first_platoon/views/teacher_view/teacher_add_new/add_quiz_view.dart';
import 'package:first_platoon/views/teacher_view/teacher_add_new/add_assignment_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/add_compaigns_controller.dart';

class AddNewTabsView extends StatelessWidget {
  AddNewTabsView({super.key});

  final ctrl = Get.put(AddCompaignsConteroller());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Add New"),
          bottom: const TabBar(tabs: [
            Tab(text: "Quiz"),
            Tab(text: "Assignments"),
            Tab(text: "Add Student"),
          ]),
        ),
        body: TabBarView(
          children: [
            AddQuizView(),
            AddAssignmentView(),
            AddStudentView(),
          ],
        ),
      ),
    );
  }
}
