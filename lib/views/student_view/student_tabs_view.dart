import 'package:first_platoon/core/functions.dart';
import 'package:first_platoon/views/student_view/student_assignments/student_assignment_tabs.dart';
import 'package:first_platoon/views/student_view/student_quiz_view.dart';
import 'package:flutter/material.dart';

class StudentTabView extends StatefulWidget {
  const StudentTabView({super.key});

  @override
  State<StudentTabView> createState() => _StudentTabViewState();
}

class _StudentTabViewState extends State<StudentTabView> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: pageIndex,
          children: const [
            StudentQuizView(),
            StudentAssignmentTabs(),
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
                icon: Icon(Icons.arrow_circle_up_rounded), label: "Quiz"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_up_rounded), label: "Assignmnt"),
          ],
        ),
      ),
    );
  }
}
