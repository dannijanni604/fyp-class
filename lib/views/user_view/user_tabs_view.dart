import 'package:first_platoon/core/functions.dart';
import 'package:first_platoon/views/user_view/user_task/user_hitlist_tabs.dart';
import 'package:first_platoon/views/user_view/user_schedule_view.dart';
import 'package:flutter/material.dart';

class UserHomeView extends StatefulWidget {
  const UserHomeView({super.key});

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: pageIndex,
          children: const [
            UserScheduleView(),
            UserHitlistView(),
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
                icon: Icon(Icons.arrow_circle_up_rounded), label: "Schedule"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_up_rounded), label: "Task"),
          ],
        ),
      ),
    );
  }
}
