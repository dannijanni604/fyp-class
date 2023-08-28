import 'package:flutter/material.dart';

import '../../core/components/app_textfield.dart';
import '../../core/components/app_text_card.dart';
import '../../core/theme.dart';

class StudentChatView extends StatelessWidget {
  const StudentChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Group Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return AppTextCard();
              },
            ),
          ),
          const SizedBox(height: 6),
          const StudentTextField(),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
