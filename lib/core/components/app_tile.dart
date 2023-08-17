import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

appTile({
  Widget? child,
  VoidCallback? onpress,
}) {
  return GestureDetector(
    onTap: onpress,
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      width: Get.size.width * 0.95,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        // border: Border.all(color: Colors.black26),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.black12,
        //     spreadRadius: 1,
        //     blurRadius: 5,
        //     offset: Offset(0, 1),
        //   ),
        // ],
      ),
      child: child,
    ),
  );
}
