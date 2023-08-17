import 'package:first_platoon/core/theme.dart';
import 'package:flutter/material.dart';

Widget kAppButton({
  String? label,
  Color? color,
  EdgeInsetsGeometry? padding,
  Widget? child,
  VoidCallback? onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        border: Border.all(
          color: AppTheme.kprimaryColor,
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0.6, -0.1)),
        ],
      ),
      child: Center(child: child ?? Text(label ?? "Label")),
    ),
  );
}
