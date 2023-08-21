import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/student_view/student_assignments/student_assignment_history_view.dart';
import 'package:first_platoon/views/student_view/student_assignments/student_assignment_view.dart';
import 'package:flutter/material.dart';

class StudentAssignmentTabs extends StatelessWidget {
  const StudentAssignmentTabs({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return DefaultTabController(
      length: 2,
      initialIndex: index,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.kblueColor,
          automaticallyImplyLeading: false,
          title: const TabBar(
            tabs: [
              Tab(
                text: "Assignments",
              ),
              Tab(
                text: "History",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            StudentAssignmentView(),
            StudentAssignmentHistoryView(),
          ],
        ),
      ),
    );
  }
}
