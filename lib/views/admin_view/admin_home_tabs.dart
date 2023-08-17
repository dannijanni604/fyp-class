import 'package:first_platoon/controllers/admin_controller.dart';
import 'package:first_platoon/controllers/schedule_controller.dart';
import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/functions.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/admin_view/admin_add_new/add_admin_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_hitlist_view.dart';
import 'admin_manage/admin_manage_tabs.dart';
import 'admin_schedule_view.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
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
              AdminScheduleView(),
              AdminHitlistView(),
              const AdminManageTabsView(),
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
                label: "Schedule",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_up_rounded),
                label: "Task",
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
              appNavPush(context, AdminAddNew());
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
