import 'package:first_platoon/core/components/snackbar.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextCard extends StatelessWidget {
  AppTextCard({Key? key, this.textData}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  var textData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onLongPress: () {
                    //  Clipboard.setData(ClipboardData(text: codeText));
                    sendAlert("Message Copied");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.all(6),
                    child: Text(
                      // textData.text,
                      "Reloaded 1 of 1824 libraries in 1,646ms (compile: 59 ms, reload: 609 ms, reassemble: 862 ms). ",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
