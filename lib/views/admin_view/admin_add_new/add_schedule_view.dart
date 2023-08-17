import 'package:first_platoon/controllers/add_compaigns_controller.dart';
import 'package:first_platoon/core/components/app_button.dart';
import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddScheduleView extends StatelessWidget {
  AddScheduleView({super.key});

  final _key = GlobalKey<FormState>();
  final ctrl = Get.find<AddCompaignsConteroller>();

  @override
  Widget build(BuildContext context) {
    // ctrl.change(null, status: RxStatus.success());
    final size = Get.size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Schedule"),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                controller: ctrl.scheduleTaskController,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Add Schedule";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text("Date"),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFormField(
                controller: ctrl.scheduledateController,
                onTap: () async {
                  DateTimeRange? range = await dateTimeRangePicker(context);
                  if (range != null) {
                    ctrl.scheduledDateTime = range;
                    ctrl.scheduledateController.text =
                        "${range.start.toString().substring(0, 10)} - ${range.end.toString().substring(0, 10)}";
                  }
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter Date";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text("Add Members"),
              Obx(() {
                return Wrap(
                  spacing: 2,
                  runSpacing: -3,
                  children: [
                    ...ctrl.scheduleMembers
                        .map(
                          (e) => Chip(
                            onDeleted: () {
                              ctrl.scheduleMembers.remove(e);
                              // ctrl.scheduleMembers.value =
                              //     ctrl.scheduleMembers.toSet().toList();
                            },
                            label: Text(e['name']),
                          ),
                        )
                        .toList(),
                  ],
                );
              }),
              SizedBox(
                height: size.height * 0.01,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "search members here",
                ),
                controller: ctrl.scheduleMemberController,
                onChanged: (v) {
                  ctrl.searchMember(v.toLowerCase());
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ctrl.obx(
                  (state) {
                    if (ctrl.members.isNotEmpty) {
                      return Wrap(
                        direction: Axis.horizontal,
                        spacing: 5,
                        runSpacing: -3,
                        children: [
                          ...ctrl.members.map((e) {
                            return Chip(
                              onDeleted: () {
                                bool already = ctrl.scheduleMembers
                                    .any((m) => m['id'] == e['id']);
                                if (!already) {
                                  ctrl.scheduleMembers.add(e);
                                }
                              },
                              deleteIcon: Icon(Icons.add, size: 20),
                              padding: EdgeInsets.all(1),
                              label: Text(
                                e['name'],
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    }
                    return const Center(
                      child: Text("No User"),
                    );
                  },
                  onLoading: const Center(child: CircularProgressIndicator()),
                ),
              ),
              Obx(
                () {
                  return Center(
                    child: ctrl.indicator.value
                        ? const CircularProgressIndicator()
                        : Column(
                            children: [
                              kAppButton(
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    if (ctrl.scheduleMembers.isNotEmpty) {
                                      ctrl.addSchedule();
                                    } else {
                                      kerrorSnackbar(
                                          message: "Add Members List");
                                    }
                                  }
                                },
                                label: "Generate Schedule",
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              SizedBox(
                                height: size.height * 0.04,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                ),
                              )
                            ],
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
