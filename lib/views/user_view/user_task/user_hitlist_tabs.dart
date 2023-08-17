import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/user_view/user_task/user_hitlist_history_view.dart';
import 'package:first_platoon/views/user_view/user_task/user_hitlist_task_view.dart';
import 'package:flutter/material.dart';

class UserHitlistView extends StatelessWidget {
  const UserHitlistView({super.key});

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
                text: "Task",
              ),
              Tab(
                text: "Task History",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserHitListTaskView(),
            UserHitListHistoryView(),
          ],
        ),
      ),
    );
  }
}
