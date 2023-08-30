import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/controllers/group_chat_controller.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TeacherChatView extends StatelessWidget {
  TeacherChatView({super.key});
  @override
  final ctrl = Get.put(ChatController());
  final messageController = TextEditingController();
  final id = GetStorage().read('id');

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Chat"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: ctrl.fireStore
                  .collection("chat")
                  .orderBy('sendAt', descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(12),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ChatChip(
                          chat: snapshot.data!.docs[index].data(),
                          ctrl: ctrl,
                        );
                      },
                      reverse: true,
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("napshot.error.toString()"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          const SizedBox(height: 12),
          ctrl.currentUserID.isEmpty
              ? SizedBox()
              : Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(fontSize: 14),
                        controller: messageController,
                        maxLines: null,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Write Your Message"),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () async {
                        await ctrl.fireStore.collection("chat").doc().set({
                          'uid': ctrl.currentUserID,
                          'message': messageController.text,
                          'sendAt': FieldValue.serverTimestamp(),
                        });
                        messageController.clear();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.circular(40)),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
          // AppTextField(
          //   onDocTap: () {},
          //   onSendTap: () {},
          // ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class ChatChip extends StatelessWidget {
  Map<String, dynamic> chat;
  ChatController ctrl;
  ChatChip({
    required this.chat,
    required this.ctrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isauth = ctrl.currentUserID == chat['uid'];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          isauth ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isauth
            ? SizedBox()
            : Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
        BubbleSpecialOne(
          delivered: true,
          text: chat['message'] ?? "",
          isSender: isauth ? true : false,
          color: Colors.purple.shade100,
          textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.purple,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
          // seen: true,
        ),
        isauth
            ? Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
