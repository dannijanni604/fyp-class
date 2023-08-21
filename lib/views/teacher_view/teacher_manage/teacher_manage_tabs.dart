import 'package:first_platoon/views/teacher_view/teacher_manage/teacher_manage_history_view.dart';
import 'package:first_platoon/views/teacher_view/teacher_manage/teacher_manage_assignments_view.dart';
import 'package:flutter/material.dart';

class TeacherManageTabsView extends StatelessWidget {
  const TeacherManageTabsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const TabBar(tabs: [
            Tab(
              text: "Manage Assignments",
            ),
            Tab(
              text: "History",
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            TeacherManageAssignmentsView(),
            TeacherManageHistoryView(),
          ],
        ),
      ),
    );
  }
}
