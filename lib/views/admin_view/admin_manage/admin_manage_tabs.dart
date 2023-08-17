import 'package:first_platoon/views/admin_view/admin_manage/admin_manage_history_view.dart';
import 'package:first_platoon/views/admin_view/admin_manage/admin_manage_view.dart';
import 'package:flutter/material.dart';

class AdminManageTabsView extends StatelessWidget {
  const AdminManageTabsView({super.key});

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
              text: "Manage Task",
            ),
            Tab(
              text: "Task History",
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            AdminManageTaskView(),
            AdminManageHistoryView(),
          ],
        ),
      ),
    );
  }
}
