import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  static CollectionReference<Map<String, dynamic>> admins =
      FirebaseFirestore.instance.collection("admins");
  static CollectionReference<Map<String, dynamic>> schedules =
      FirebaseFirestore.instance.collection("schedules");
  static CollectionReference<Map<String, dynamic>> tasks =
      FirebaseFirestore.instance.collection("tasks");
  static CollectionReference<Map<String, dynamic>> members =
      FirebaseFirestore.instance.collection("members");
  static CollectionReference<Map<String, dynamic>> groups =
      FirebaseFirestore.instance.collection("groups");
  // static CollectionReference<Map<String, dynamic>> submittedTask =
  //     FirebaseFirestore.instance.collection("submittedTask");
}
