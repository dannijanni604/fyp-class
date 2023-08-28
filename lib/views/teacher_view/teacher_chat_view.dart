import 'package:first_platoon/core/components/app_text_card.dart';
import 'package:flutter/material.dart';
import '../../core/components/app_textfield.dart';

class TeacherChatView extends StatelessWidget {
  const TeacherChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Chat"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return AppTextCard();
              },
              // reverse: true,
            ),
          ),
          const SizedBox(height: 12),
          AppTextField(
            onDocTap: () {},
            onSendTap: () {},
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
