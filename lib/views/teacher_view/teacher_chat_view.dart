import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_platoon/controllers/group_chat_controller.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherChatView extends StatelessWidget {
  TeacherChatView({super.key});
  @override
  final ctrl = Get.put(ChatController());

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                        ctrl.isauth = ctrl.currentUserID ==
                            snapshot.data!.docs[index]['uid'];
                        return Column(
                          children: [
                            // IconButton(
                            //     onPressed: () {
                            //       FirebaseFirestore.instance
                            //           .collection('chat')
                            //           .doc(snapshot.data!.docs[index].id)
                            //           .delete();
                            //     },
                            //     icon: const Icon(
                            //       Icons.delete,
                            //     )),
                            ChatChip(
                              chat: snapshot.data!.docs[index].data(),
                              ctrl: ctrl,
                            ),
                          ],
                        );
                      },
                      reverse: true,
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          const SizedBox(height: 12),
          Row(
            children: [
              ctrl.auth.currentUser != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          ctrl.picDocuments();
                        },
                        child: const Icon(
                          Icons.attachment_rounded,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    )
                  : SizedBox(width: 5),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontSize: 14),
                  controller: ctrl.messageController,
                  maxLines: null,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.black12,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)),
                    hintText: "Write Your Message",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () async {
                    await ctrl.fireStore.collection("chat").doc().set({
                      'uid': ctrl.currentUserID,
                      'message': ctrl.messageController.text,
                      'type': "text",
                      'sendAt': FieldValue.serverTimestamp(),
                    });
                    ctrl.messageController.clear();
                  },
                  child: const Icon(
                    Icons.send,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          ctrl.isauth ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (ctrl.pickedDocuments.isNotEmpty)
          ctrl.isauth
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
        chat['type'] == 'text'
            ? BubbleSpecialOne(
                delivered: true,
                text: chat['message'] ?? "",
                isSender: ctrl.isauth ? true : false,
                color: Colors.purple.shade100,
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.purple,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
                // seen: true,
              )
            : Container(
                child: Column(
                children: [
                  ...chat['message']
                      .map((e) => Container(
                            height: 200,
                            width: 150,
                            child: Image.network(
                              e,
                              fit: BoxFit.fill,
                            ),
                          ))
                      .toList(),
                ],
              )),
        ctrl.isauth
            ? chat['type'] == 'doc'
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
                  )
            : SizedBox(),
      ],
    );
  }
}
