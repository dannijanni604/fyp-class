import 'dart:io';
import 'package:first_platoon/core/theme.dart';
import 'package:first_platoon/views/splash_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_view/flutter_file_view.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  FlutterFileView.init();
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA5KKSDYkVcVuuJ6b4hApg1aDbuHUjjza0",
        appId: "1:985768952453:web:a567ff449c413dc899dfec",
        messagingSenderId: "985768952453",
        projectId: "management-app-9e566",
        storageBucket: "management-app-9e566.appspot.com",
      ),
    );
  }
  runApp(const ManagementApp());
}

class ManagementApp extends StatelessWidget {
  const ManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final Color green = Colors.deepOrange;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppTheme.primaryColor,
        fontFamily: "montserrat",
        // accentIconTheme: IconThemeData(size: 30),

        iconTheme: const IconThemeData(size: 30),

        // scaffoldBackgroundColor: Color(0xFFFCFBF4),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.kprimaryColor,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
      home: const SplashView(),
    );
  }
}