import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_platoon/core/theme.dart';
import 'package:flutter/material.dart';

isAuthUserChip(
    {AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? snapshot,
    int? index}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.all(6),
          child: Text(
            snapshot!.data!.docs[index!].data()['message'],
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(width: 12),
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
        // IconButton(
        //     onPressed: () {
        //       FirebaseFirestore.instance
        //           .collection('chat')
        //           .doc(snapshot.data!.docs[index].id)
        //           .delete();
        //     },
        //     icon: Icon(Icons.delete)),
      ],
    ),
  );
}

isOtherUserChip(
    {AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? snapshot,
    int? index}) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
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
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.all(6),
          child: Text(
            snapshot!.data!.docs[index!].data()['message'],
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    ),
  );
}
