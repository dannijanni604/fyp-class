import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_platoon/controllers/assignment_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/components/app_tile.dart';
import 'package:first_platoon/core/const.dart';
import 'package:first_platoon/core/db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class StudentAssignmentView extends StatelessWidget {
  const StudentAssignmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final id = GetStorage().read('id');
    log("Id ID $id");

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: DB.tasks
          // .orderBy('due_date', descending: false)
          .where('members', arrayContains: id)
          .where('status', isNull: true)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.docs.isEmpty
              ? const Center(
                  child: Text("No Assignment"),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return appTile(
                      onpress: () {
                        showUserHitlitBottomSheet(
                          context: context,
                          index: index,
                          snapshot: snapshot,
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                DateFormat('MMM d').format(
                                  DateTime.parse(snapshot.data!.docs[index]
                                          .data()['due_date'] +
                                      "00:00:00"),
                                ),
                              ),
                            ],
                          ),
                          Text(snapshot.data!.docs[index].data()['task'],
                              style: Const.labelText()),
                          // Text(snapshot.data!.docs[index].data()['auth_id']),
                        ],
                      ),
                    );
                  });
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

showUserHitlitBottomSheet({
  BuildContext? context,
  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? snapshot,
  int? index,
}) {
  final ctrl = Get.put(HitlistController());

  return showModalBottomSheet(
      context: context!,
      builder: (context) {
        return Obx(() {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                            "Add Documents For ${snapshot!.data!.docs[index!].data()['task']}",
                            style: Const.labelText())),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.cancel_outlined),
                    )
                  ],
                ),
                Container(
                  height: 150,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          height: 200,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () {
                              ctrl.picDocuments();
                              Get.back();
                            },
                            icon: Icon(
                              Icons.image,
                              color: Colors.deepOrange.withOpacity(0.5),
                            ),
                          ),
                        ),
                        ...ctrl.pickedFile.map((i) {
                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(3),
                            padding: EdgeInsets.all(5),
                            height: 200,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(i.path))),
                            ),
                            child: Text(
                              i.path
                                  .split(
                                    '.',
                                  )
                                  .last,
                              style: const TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                ctrl.isClicked.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : kAppButton(
                        onPressed: () {
                          ctrl.onUserCompleteTask(
                            index: index,
                            snapshot: snapshot,
                          );
                        },
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        label: "Submit Assignment"),
              ],
            ),
          );
        });
      });
}
