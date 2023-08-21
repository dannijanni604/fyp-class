import 'package:first_platoon/controllers/admin_controller.dart';
import 'package:first_platoon/controllers/quiz_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/functions.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/teacher_view/teacher_add_new/add_new_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'teacher_assignments_view.dart';
import 'teacher_manage/teacher_manage_tabs.dart';
import 'teacher_quiz_view.dart';

class TeacherHomeView extends StatefulWidget {
  const TeacherHomeView({super.key});

  @override
  State<TeacherHomeView> createState() => _TeacherHomeViewState();
}

class _TeacherHomeViewState extends State<TeacherHomeView> {
  int pageIndex = 0;
  final ctrl = Get.put(ScheduleController());
  final adminCtrl = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: adminCtrl.obx(
        (state) => Scaffold(
          body: IndexedStack(
            index: pageIndex,
            children: [
              TeacherQuizView(),
              TeacherAssignmentsView(),
              const TeacherManageTabsView(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int newIndex) {
              setState(() {
                pageIndex = newIndex;
              });
            },
            currentIndex: pageIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_up_rounded),
                label: "Quiz",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_up_rounded),
                label: "Assignments",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_up_rounded),
                label: "Manage",
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme.primaryColor,
            onPressed: () async {
              appNavPush(context, AddNewTabsView());
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
        onLoading: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
