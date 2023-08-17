import 'package:first_platoon/views/admin_view/admin_add_new/add_member_view.dart';
import 'package:first_platoon/views/admin_view/admin_add_new/add_schedule_view.dart';
import 'package:first_platoon/views/admin_view/admin_add_new/add_tasks_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/add_compaigns_controller.dart';

class AdminAddNew extends StatelessWidget {
  AdminAddNew({super.key});

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
            Tab(text: "Schedule"),
            Tab(text: "Tasks"),
            Tab(text: "Add Member"),
          ]),
        ),
        body: TabBarView(
          children: [
            AddScheduleView(),
            AddTasksView(),
            AddMemberView(),
          ],
        ),
      ),
    );
  }
}
