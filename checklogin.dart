// ignore_for_file: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class user1 extends StatefulWidget {
  const user1 ({super.key});

  @override
  State<user1> createState() => _userState();
}

class _userState extends State<user1> {


  @override
  Widget build(BuildContext context) {
    User? name = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
              },
              child: const Text("logout"),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("students")
                  .where("id", isEqualTo: name.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("error");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return  Text("data not found");
                }
                if (snapshot.data != null) {
                  Text(
                    name.uid
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}