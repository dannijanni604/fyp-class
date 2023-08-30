import 'package:first_platoon/core/app_navigator.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/auth_views/auth_options_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class StudentQuizView extends StatelessWidget {
  const StudentQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    final id = GetStorage().read('id');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.kblueColor,
        automaticallyImplyLeading: false,
        title: const Text("Quiz"),
        actions: [
          IconButton(
              onPressed: () {
                GetStorage().erase();
                appNavReplace(context, const AuthOptionsView());
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: StreamBuilder(
        stream: DB.schedules.where('members', arrayContains: [id]).snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? const Center(child: Text("No Quiz"))
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      return appTile(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                  snapshot.data!.docs[index].data()['schdule'],
                                  style: Const.labelText()),
                            ),
                            Text(
                              dateString(
                                snapshot.data!.docs[index]
                                    .data()['date']
                                    .toDate(),
                                snapshot.data!.docs[index]
                                    .data()['end_date']
                                    .toDate(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  String dateString(DateTime st, DateTime en) {
    if (st.month == en.month) {
      return "${DateFormat('MMM d').format(st)}-${DateFormat('d').format(en)}";
    }
    return "${DateFormat('MMM d').format(st)}-${DateFormat('MMM d').format(en)}";
  }
}
