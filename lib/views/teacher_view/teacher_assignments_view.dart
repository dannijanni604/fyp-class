import 'package:first_platoon/controllers/admin_controller.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/core/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TeacherAssignmentsView extends StatelessWidget {
  TeacherAssignmentsView({super.key});

  final adminCtrl = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    // final ctrl = Get.put(HitlistController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Assignments"),
      ),
      body: StreamBuilder(
        stream: DB.tasks
            .where('doc_id', isEqualTo: adminCtrl.admin.groupId)
            .where('status', isNull: true)
            .orderBy('due_date')
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.docs.isEmpty
                ? const Center(
                    child: Text("No Assignments"),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      List<String> members = List.from(
                              snapshot.data!.docs[index].data()['members'])
                          .cast<String>();
                      String task = snapshot.data!.docs[index].data()['task'];

                      return appTile(
                        onpress: () {
                          showMembersBottomSheet(
                            context: context,
                            members: members,
                            task: task,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(task, style: Const.labelText()),
                            ),
                            Text(
                              DateFormat('MMM d').format(
                                DateTime.parse(snapshot.data!.docs[index]
                                        .data()['due_date'] +
                                    "00:00:00"),
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text("Are you sure to delete?"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  await DB.tasks
                                                      .doc(snapshot
                                                          .data!.docs[index].id)
                                                      .delete();
                                                  Get.back();
                                                },
                                                child: const Text('Delete'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text('Cancel'),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.delete,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      );
                    });
          } else if (snapshot.hasError) {
            printInfo(info: snapshot.error.toString());
            print(snapshot.error);

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
}
