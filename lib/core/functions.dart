import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/db.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

DateTime? currentBackPressTime;
Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    ksucessSnackbar(message: "Press Again To Exit App");
    return Future.value(false);
  }
  return Future.value(true);
}

showMembersBottomSheet(
    {BuildContext? context, List<String>? members, String? task}) {
  showModalBottomSheet(
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      context: context!,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              height: 50,
              decoration: const BoxDecoration(
                color: AppTheme.kprimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Assignment Members"),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_drop_down_outlined,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              height: 200,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    ...members!.map(
                      (e) =>
                          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: DB.members.doc(e).get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Wrap(
                                spacing: 5,
                                runSpacing: -3,
                                children: [
                                  Chip(
                                    backgroundColor: Colors.black12,
                                    label: Text(snapshot.data!.data()!['name']),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Transform(
                              transform: Matrix4.identity()..scale(0.6),
                              child: const CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      });
}

Color statusColor(String status) {
  status = status.toLowerCase();
  switch (status) {
    case 'approved':
      return Colors.green.shade300;
    case 'processing':
      return Colors.yellow;
    default:
  }
  return Colors.red.shade300;
}

Widget statusChip({String label = '', String? color}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
    decoration: BoxDecoration(
      color: statusColor(color!),
      borderRadius: BorderRadius.circular(50),
    ),
    child: Text(label),
  );
}

Future<DateTimeRange?> dateTimeRangePicker(BuildContext context) async {
  DateTimeRange? picked = await showDateRangePicker(
    context: context,
    firstDate: DateTime(DateTime.now().year - 5),
    lastDate: DateTime(DateTime.now().year + 5),
    initialDateRange: DateTimeRange(
      end: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 13),
      start: DateTime.now(),
    ),
  );
  return picked;
}
