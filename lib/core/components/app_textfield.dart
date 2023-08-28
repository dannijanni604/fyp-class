import 'package:first_platoon/core/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final VoidCallback? onSendTap;
  final VoidCallback? onDocTap;

  const AppTextField({
    Key? key,
    this.textEditingController,
    this.onSendTap,
    this.onDocTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0, left: 4, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.50),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 50),
                          child: Scrollbar(
                            child: TextFormField(
                              style: const TextStyle(fontSize: 14),
                              controller: textEditingController,
                              maxLines: null,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Write Your Message"),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
              splashRadius: 20,
              onPressed: onDocTap,
              icon: const Icon(
                Icons.attachment_rounded,
                size: 20,
              )),
          InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onSendTap,
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
          const SizedBox(width: 6)
        ],
      ),
    );
  }
}

class StudentTextField extends StatelessWidget {
  const StudentTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0, left: 4, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.50),
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ]),
              child: const Row(
                children: [
                  SizedBox(width: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Text("Students Can't Send Messages Yet"),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5),
          InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 6)
        ],
      ),
    );
  }
}
